variable "projects" {
  type = list(string)
}

resource "env0_project" "this" {
  for_each = toset(var.projects)
  name     = each.value
}

# TODO ADD CREDENTIALS
# https://registry.terraform.io/providers/env0/env0/latest/docs/resources/cloud_credentials_project_assignment
