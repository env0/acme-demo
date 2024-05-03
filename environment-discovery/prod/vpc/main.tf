terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.66.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  region = "us-west-2"
}

module "vpc" {
  source  = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/vpc/env0"
  version = "0.1.4"

  name   = "ed-vpc"
  region = local.region
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "vpc id"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "cidr block"
}

output "azs" {
  value       = module.vpc.azs
  description = "availability zones"
}

output "region" {
  value       = local.region
  description = "region"
}