# terraform {
#   required_providers {
#     env0 = {
#       version = "6.6.6"
#       source  = "terraform.env0.com/local/env0"
#     }
#   }
# }
terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = ">= 1.0.5"
    }
  }
}

data "env0_project" "myproject" {
  name = var.project_name
}

variable "project_name" {
  type = string
  default = "Arnold's Developers"
}

data "env0_template" "mytemplate" {
  name = var.template_name
}

variable "template_name" {
  type = string
  default = "frontend layer"
}

variable "environment_name" {
  type = string
  default = "Frontend Layer - DevTest"
}

resource "env0_environment" "environment" {
  name        = var.environment_name
  project_id  = data.env0_project.myproject.id
  template_id = data.env0_template.mytemplate.id
  configuration {
    name  = "refresh_date"
    value = "1/1/2001"
    type  = "terraform"
  }
}

output "project" {
  value = data.env0_project.myproject
}

output "template" {
  value = data.env0_template.mytemplate
}

output "environment" {
  value = env0_environment.random_environment
}