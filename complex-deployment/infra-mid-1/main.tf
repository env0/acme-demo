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

variable "project_id" {
  type = string
}

variable "env_name" {
  type    = string
  default = ""
}

variable "deployment_key"{
  type = string
  default = "000"
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.infra_base
}

resource "env0_configuration_variable" "infra_mid" {
  name         = "${var.deployment_key}_${var.env_name}"
  project_id   = var.project_id
  value        = "${var.env_name}_${module.infra.random_string}"
  is_read_only = true
  type         = "terraform"
}

data "env0_configuration_variable" "infra_base" {
  project_id = var.project_id
  name = "${var.deployment_key}_infra_base"
}

output "depends_on" {
  value = data.env0_configuration_variable.infra_base.value
}

output "infra_name" {
  value = "${var.env_name}_${module.infra.random_string}"
}
