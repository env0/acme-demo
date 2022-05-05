terraform {
  required_version = "~>0.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
    env0 = {
      source = "env0/env0"
      version = ">= 1.0.2"
    }
  }

  backend "s3" {
    dynamodb_table = "acme-dev-tfstate-lockdb"
    key            = "simple-vpc"
    region         = "us-west-2"
  }
}

provider "aws" {
  region = var.region
}

