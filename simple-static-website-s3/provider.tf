terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }

  backend "s3" {
    bucket         = "env0-acme-tfstate"
    dynamodb_table = "env0-acme-tfstate-lock"
    key            = "acme-demo-s3"
    region         = "us-east-2"
    # the role is being assumed from the deployer role - so you will need to configure assume role chaining
    role_arn       = "arn:aws:iam::326535729404:role/env0-acme-assume-role" 
    # external_id    = "value"  # (optional) use ENV0_TERRAFORM_BACKEND_CONFIG=external_id=[external_id_value]
  }
}

provider "aws" {
  region = "us-east-2"
}
