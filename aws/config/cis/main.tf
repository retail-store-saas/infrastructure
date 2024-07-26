provider "aws" {
  region = var.region
}


resource "aws_iam_role" "support_role" {
  name = "config-support-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
}

resource "aws_iam_policy" "support_policy" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "support:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "support_policy_attach" {
  name       = "config-support-role"
  roles      = [aws_iam_role.support_role.name]
  policy_arn = aws_iam_policy.support_policy.arn
}

module "config_cis-1-2-rules" {
  source  = "cloudposse/config/aws//modules/cis-1-2-rules"
  version = "0.16.0"

  support_policy_arn     = aws_iam_policy.support_policy.arn
  cloudtrail_bucket_name = var.cloudtrail_bucket_name
  parameter_overrides    = var.parameter_overrides
}

module "aws_config_storage" {
  source  = "cloudposse/config-storage/aws"
  version = "0.8.1"

  name          = "srs-config-storage"
  force_destroy = var.force_destroy
}

module "aws_config" {
  source  = "cloudposse/config/aws"
  version = "0.16.0"

  create_sns_topic                 = false
  create_iam_role                  = var.create_iam_role
  managed_rules                    = module.config_cis-1-2-rules.rules
  force_destroy                    = var.force_destroy
  s3_bucket_id                     = module.aws_config_storage.bucket_id
  s3_bucket_arn                    = module.aws_config_storage.bucket_arn
  global_resource_collector_region = var.global_resource_collector_region
}

data "aws_caller_identity" "current" {}
