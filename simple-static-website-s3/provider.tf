terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }

  backend "s3" {
    bucket         = "env0-acme-tfstate"
    dynamodb_table = "env0-acme-tfstate-lock"
    key            = "acme-demo-s3"
    region         = "us-west-2"
    role_arn       = "arn:aws:iam::326535729404:role/env0-acme-assume-role"
    //external_id    = "value"
  }
}

provider "aws" {
  region = "us-west-2"
}