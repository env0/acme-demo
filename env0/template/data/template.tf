terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.19"
    }
  }
}

provider "env0" {
}

data "env0_template" "mytemplate" {
  name = var.template_name
}

variable "template_name" {
  type    = string
  default = "prod-my-randomstring"
}

output "template" {
  value = data.env0_template.mytemplate
}