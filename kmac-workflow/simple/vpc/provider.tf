terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.68.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}