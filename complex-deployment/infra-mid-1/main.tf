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

variable "deployment_key" {
  type    = string
  default = "000"
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = "${var.deployment_key}_${var.env_name}"
}

output "infra_name" {
  value = "${var.env_name}_${module.infra.random_string}"
}
