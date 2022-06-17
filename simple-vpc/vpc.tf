locals {
  environment_vars = fileexists("env0.system-env-vars.json") ? jsondecode(file("env0.system-env-vars.json")) : jsondecode("{\"result\"}:{\"env0.system-env-vars.json not found\"}")
  project_id       = local.environment_vars["ENV0_PROJECT_ID"]
}

module "acme-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.1.0"

  name = var.name
  cidr = var.cidr

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = true
  one_nat_gateway_per_az = false


  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

resource "env0_configuration_variable" "vpc_id" {
  name        = "vpc_id"
  value       = module.acme-vpc.vpc_id
  description = "vpc_id for project"
  project_id  = local.project_id
}

