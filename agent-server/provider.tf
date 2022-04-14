terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.0"
    }
  }

  backend "s3" {
    bucket   = "env0-acme-tfstate"
    key      = "agent-server"
    region   = "us-west-2"
    role_arn = "arn:aws:iam::326535729404:role/env0-acme-assume-role"
  }
}

provider "aws" {
  region = "us-west-2"
}