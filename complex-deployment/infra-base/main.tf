terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = ">= 0.2.28"
    }
  }
}

variable "length" {
  type    = number
  default = 5
}

variable "refresh_token" {
  type    = string
  default = "0"
}

variable "project_id" {
  type = string
}

variable "deployment_key"{
  type = string
  default = "000"
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.refresh_token
}

output "infra_name" {
  value = "infra_base_${module.infra.random_string}"
}

resource "env0_configuration_variable" "infra_base" {
  name         = "${var.deployment_key}_infra_base"
  project_id   = var.project_id
  value        = "infra_base_${module.infra.random_string}"
  is_read_only = true
  type         = "terraform"
}