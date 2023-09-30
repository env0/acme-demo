
module "projects" {
  # public repo
  # source = "git@github.com:env0/terraform-env0-project.git"
  # private module registry
  source  = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/project/env0"
  version = ">= 0.2"

  projects = var.projects
}