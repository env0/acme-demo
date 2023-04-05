terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "> 1.0.0"
    }
  }
}

provider "env0" {
  organization_id = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"
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
