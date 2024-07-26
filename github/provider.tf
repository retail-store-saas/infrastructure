terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.28.0"
    }
  }
  backend "s3" {
    encrypt        = true
    bucket         = "srs-terraform-state-storage-eu-west-1"
    key            = "github/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "srs-terraform-state-storage-lock-eu-west-1"
  }
}

provider "github" {
  owner = "retail-store-saas"
}
