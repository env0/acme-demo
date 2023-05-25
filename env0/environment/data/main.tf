terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = ">= 1.0.2"
    }
  }
}

variable "name" {
  type    = string
  default = "FrontEnd Servers (EC2)-8826"
}

data "env0_environment" "this" {
  name = var.name
  //project_id = "7320dd7a-4822-426c-84b5-62ddd8be0799"
}

output "env0_environment" {
  value = data.env0_environment.name
}

