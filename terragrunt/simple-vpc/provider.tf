terraform {
  required_version = "~>0.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

