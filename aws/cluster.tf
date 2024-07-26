provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.cluster.cluster_id]
  }
}

# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
module "cluster" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.28.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # eks_managed_node_group_defaults = {
  #   disk_size      = 50
  #   instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  # }

  eks_managed_node_groups = {
    blue = {
      cluster_version = "1.23"
      min_size        = 1
      max_size        = 10
      desired_size    = 4

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      iam_role_additional_policies = [
        aws_iam_policy.aws_otel.arn,
        aws_iam_policy.msk_admin_rw.arn
      ]
    }
    # green = {
    #   min_size     = 1
    #   max_size     = 10
    #   desired_size = 4

    #   instance_types = ["t3.large"]
    #   capacity_type  = "SPOT"
    #   iam_role_additional_policies = [
    #     aws_iam_policy.aws_otel.arn
    #   ]
    # }
  }

  node_security_group_additional_rules = {
    ingress_allow_all_node_to_node = {
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "all"
      self        = true
      description = "Allow all access between nodes"
    }
    egress_allow_all_node_to_node = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "all"
      self        = true
      description = "Allow all access between nodes"
    }
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    egress_allow_all = {
      description = "Allow all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  manage_aws_auth_configmap = true
  aws_auth_users = [
    {
      userarn  = aws_iam_user.breakglass_administrator.arn
      username = aws_iam_user.breakglass_administrator.name
      groups   = ["system:masters"]
    }
  ]
}
