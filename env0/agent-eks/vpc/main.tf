module "vpc" {
  source          = "git@github.com:env0/k8s-modules.git//aws/vpc?ref=feat/vpc-dynamic-azs"

  cluster_name    = var.cluster_name
  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
  default = ""
}

variable "cidr" {
  type = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default = "172.16.0.0/16"
}

variable "private_subnets" {
  type = string
  description = "List of private subnets inside the VPC"
  default = ["172.16.0.0/21", "172.16.16.0/21", "172.16.32.0/21", "172.16.48.0/21", "172.16.64.0/21"]
}

variable "public_subnets" {
  type = string
  description = "List of public subnets inside the VPC"
  default = ["172.16.8.0/22", "172.16.24.0/22", "172.16.40.0/22", "172.16.56.0/22", "172.16.72.0/22"]
}


output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC id"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  value       = module.vpc.private_subnets
}