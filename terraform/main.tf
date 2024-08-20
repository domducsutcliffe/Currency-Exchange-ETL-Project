terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
  bucket = "currency-exchange-backend"
  key    = "state/terraform.tfstate"
  region = "eu-west-2"

  }
}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      ProjectName  = "Currency Exchange"
      DeployedFrom = "Terraform"
      Repository   = "de-currency-exchange"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}