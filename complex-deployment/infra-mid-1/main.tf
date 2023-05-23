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

variable "env_name" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.vpc_id
}
  
output "cluster_name" {
  value = "cluster-${var.vpc_id}"
}
  
output "vpc_id" {
  value = var.vpc_id
}
