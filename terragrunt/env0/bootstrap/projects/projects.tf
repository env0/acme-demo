variable "projects" {
  type = list(string)
}

# should really only be run once, does not handle recreation
resource "env0_project" "this" {
  for_each = toset(var.projects)
  name     = each.value
}