terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    env0 = {
      source = "env0/env0"
      version = ">= 1.0"
    }
  }
}

provider "aws" {
  region = var.region
}

