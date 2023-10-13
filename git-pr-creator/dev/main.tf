terraform {
  required_version = ">= 0.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.41.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "ec2" {
  source         = "../../modules/ec2"
  instance_type  = var.instance_type
  vpc_id         = "vpc-0d806cc612e6cf9e3"
  instance_count = "1"
  name           = "Turbo Managed ec2"
  tags = {
    Terraform = "true"
    Owner     = "acme demo org"
    Demo      = "Turbo"
  }
}

variable "instance_type" {
  default = "t3a.micro"
  type    = string
}

output "instance_type" {
  value = var.instance_type
}