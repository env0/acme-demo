terraform {
  required_providers {
    env0 = {
      version = "6.6.6"
      source  = "terraform.env0.com/local/env0"
    }
  }
}

data "env0_project" "myproject" {
  name = var.project_name
}

variable "project_name" {
  type    = string
  default = "Greenfield - Dev"
}

data "env0_template" "mytemplate" {
  name = var.template_name
}

variable "template_name" {
  type    = string
  default = "prod-my-randomstring"
}

resource "env0_environment" "random_environment" {
  name        = "random environment"
  project_id  = data.env0_project.myproject.id
  template_id = data.env0_template.mytemplate.id
  configuration {
    name  = "refresh_date"
    value = "1/1/2001"
    type = "terraform"
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