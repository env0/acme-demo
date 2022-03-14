terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = ">= 0.2.28"
    }
  }
}

variable "length" {
  type    = number
  default = 5
}

variable "infra_base" {
  type    = string
  default = "0"
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.infra_base
}

output "depends_on" {
  value = var.infra_base
}

output "infra_name" {
  value = "infra_mid_${module.infra.random_string}"
}