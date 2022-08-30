data "env0_project" "default_project" {
  for_each     = var.environments
  name         = each.value.project
  depends_on = [
    env0_project.this
  ]
}

resource "env0_environment" "example" {
  for_each                         = var.environments
  name                             = each.key
  project_id                       = data.env0_project.default_project[each.key].id # we can make this more dynamic in the future based on folder structure
  run_plan_on_pull_requests        = true
  auto_deploy_on_path_changes_only = true
  deploy_on_push                   = true
  auto_deploy_by_custom_glob       = "+((../*)|(../../*)/(**)" # listen to changes up one and two levels
  force_destroy                    = true
  
  without_template_settings {
    github_installation_id = 11551359 # to get this value, you need to first build a template by hand and use the data provider
    path                   = each.value.path
    type                   = "terragrunt"
    repository             = "https://github.com/env0/acme-demo"
    description            = each.value.description
    terragrunt_version     = "0.37.4"
    terraform_version      = "1.1.9"
  }
}


variable "environments" {
  type = map(any)
}