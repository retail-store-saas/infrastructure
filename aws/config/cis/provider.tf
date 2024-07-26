terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "srs-terraform-state-storage-eu-west-1"
    key            = "aws/config/cis/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "srs-terraform-state-storage-lock-eu-west-1"
  }
}
