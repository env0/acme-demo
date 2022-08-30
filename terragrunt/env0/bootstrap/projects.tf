variable "projects" {
  type = list(string)
}

resource "env0_project" "this" {
  for_each = toset(var.projects)
  name     = each.value
  # TODO ADD CREDENTIALS
}
