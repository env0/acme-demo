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

variable "infra_base" {
  type = string
}

variable "project_id" {
  type = string
}

variable "env_name" {
  type    = string
  default = ""
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
  value = "${var.env_name}_${module.infra.random_string}"
}

resource "env0_configuration_variable" "infra_mid" {
  name         = var.env_name
  project_id   = var.project_id
  value        = "${var.env_name}_${module.infra.random_string}"
  is_read_only = true
  type         = "terraform"
}
