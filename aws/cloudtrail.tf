module "s3_bucket" {
  source  = "cloudposse/cloudtrail-s3-bucket/aws"
  version = "0.25.0"
  name    = "srs-cloudtrail-logs"
}
