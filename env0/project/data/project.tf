terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "> 1.0.0"
    }
  }
}

provider "env0" {
}

data "env0_project" "myproject" {
  name = var.project_name
}

variable "project_name" {
  type    = string
  default = "!Master Central Tooling"
}

output "project" {
  value = data.env0_project.myproject
}