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
}

variable "project_id" {
  type = string
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

resource "env0_configuration_variable" "infra_mid" {
  name         = "infra_mid"
  project_id   = var.project_id
  value        = "infra_mid_${module.infra.random_string}"
  is_read_only = true
  type         = "terraform"
}
