provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

module "securityhub-us-east-1" {
  providers = {
    aws = aws.us-east-1
  }
  source  = "cloudposse/security-hub/aws"
  version = "0.9.0"

  enabled_standards = ["standards/aws-foundational-security-best-practices/v/1.0.0", "ruleset/cis-aws-foundations-benchmark/v/1.2.0"]
  create_sns_topic  = false
}

resource "aws_securityhub_finding_aggregator" "example" {
  provider = aws.us-east-1

  linking_mode = "ALL_REGIONS"

  depends_on = [module.securityhub-us-east-1]
}

module "securityhub" {
  source  = "cloudposse/security-hub/aws"
  version = "0.9.0"

  enabled_standards = ["standards/aws-foundational-security-best-practices/v/1.0.0", "ruleset/cis-aws-foundations-benchmark/v/1.2.0"]
  create_sns_topic  = false
}
