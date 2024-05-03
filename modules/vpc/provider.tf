terraform {
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
}

provider "aws" {
  region = var.region
}

