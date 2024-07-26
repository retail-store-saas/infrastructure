locals {
  secrets = ["producer", "consumer"]
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "kafka-srs-prod"
  description = "Security group for kafka srs-prod"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules = [
    "kafka-broker-tcp",
    "kafka-broker-tls-tcp"
  ]
}

module "msk_kafka_cluster" {
  source = "terraform-aws-modules/msk-kafka-cluster/aws"

  name                   = "srs-prod"
  kafka_version          = "3.4.0"
  number_of_broker_nodes = 3
  enhanced_monitoring    = "PER_TOPIC_PER_PARTITION"

  broker_node_client_subnets = module.vpc.private_subnets
  broker_node_storage_info = {
    ebs_storage_info = { volume_size = 100 }
  }
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.security_group.security_group_id]

  encryption_in_transit_client_broker = "TLS"
  encryption_in_transit_in_cluster    = true

  cloudwatch_logs_enabled = true

  configuration_name        = "kafka-srs-prod-configuration"
  configuration_description = "SRS Prod configuration"
  configuration_server_properties = {
    "auto.create.topics.enable" = true
    "delete.topic.enable"       = true
  }
  client_authentication = {
    sasl = {
      scram = true
      iam   = true
    }
  }
  create_scram_secret_association          = true
  scram_secret_association_secret_arn_list = [for x in aws_secretsmanager_secret.this : x.arn]

  jmx_exporter_enabled  = true
  node_exporter_enabled = true

  scaling_max_capacity = 512
  scaling_target_value = 80

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

resource "aws_kms_key" "kafka_scram_key" {
  description         = "KMS CMK for kafka scram"
  enable_key_rotation = true
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_secretsmanager_secret" "this" {
  for_each = toset(local.secrets)

  name        = "AmazonMSK_${each.value}_${random_pet.this.id}"
  description = "Secret for kafka - ${each.value}"
  kms_key_id  = aws_kms_key.kafka_scram_key.key_id
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = toset(local.secrets)

  secret_id = aws_secretsmanager_secret.this[each.key].id
  secret_string = jsonencode({
    username = each.value,
    password = "${each.key}123!" # do better!
  })
}

resource "aws_secretsmanager_secret_policy" "this" {
  for_each = toset(local.secrets)

  secret_arn = aws_secretsmanager_secret.this[each.key].arn
  policy     = <<-POLICY
  {
    "Version" : "2012-10-17",
    "Statement" : [ {
      "Sid": "AWSKafkaResourcePolicy",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "kafka.amazonaws.com"
      },
      "Action" : "secretsmanager:getSecretValue",
      "Resource" : "${aws_secretsmanager_secret.this[each.key].arn}"
    } ]
  }
  POLICY
}

resource "aws_iam_policy" "msk_admin_rw" {
  name        = "kafka_admin_rw"
  path        = "/"
  description = "Grants full administrative access to kafka clusters"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "kafka-cluster:Connect",
            "kafka-cluster:AlterCluster",
            "kafka-cluster:DescribeCluster"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kafka-cluster:*Topic*",
            "kafka-cluster:WriteData",
            "kafka-cluster:ReadData"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kafka-cluster:AlterGroup",
            "kafka-cluster:DescribeGroup"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
}
