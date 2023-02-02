terraform {
  required_providers {
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.d80c9a87-2794-4f04-94fd-3fc675444072"

    workspaces {
      name = "d80c9a87-2794-4f04-94fd-3fc675444072-svc"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.d80c9a87-2794-4f04-94fd-3fc675444072"

    workspaces = {
      name = "d80c9a87-2794-4f04-94fd-3fc675444072-vpc"
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

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.refresh_token
}

output "svc_name" {
  value = "svc_${module.infra.random_string}"
}

output "vpc_name" {
  value = data.terraform_remote_state.vpc.outputs.infra_name
}