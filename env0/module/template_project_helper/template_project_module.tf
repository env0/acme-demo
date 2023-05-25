terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.19"
    }
  }
}

resource "env0_template_project_assignment" "assignment" {
  for_each    = toset(var.project_ids)
  template_id = var.template_id
  project_id  = each.value
}

variable "project_ids" {
  type = list(string)
}

variable "template_id" {
  type = string
}

output "id" {
  value = {
    for k, v in env0_template_project_assignment.assignment : k => v.id
  }
}