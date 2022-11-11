terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }

  backend "remote" {
    hostname = "backend.api.env0.com"
    organization = "dd42a409-5396-4ea5-85fe-934cc60fa04b"

    workspaces {
      name = "dev_ec2"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
