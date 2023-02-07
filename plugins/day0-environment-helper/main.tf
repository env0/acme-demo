data "env0_project" "project" {
  for_each = local.environments
  name     = each.value.project_name
}

resource "env0_environment" "dynamic_environment" {
  for_each   = local.environments
  name       = each.key
  project_id = data.env0_project.project[each.key].id
  workspace  = "dynamic-environment-${each.key}"

  //force_destroy = each.value.force_destroy
  force_destroy                    = true
  auto_deploy_on_path_changes_only = true
  deploy_on_push                   = true
  run_plan_on_pull_requests        = true
  is_remote_backend                = true

  without_template_settings {
    repository             = var.repository
    path                   = each.value.path
    type                   = "terraform"
    github_installation_id = 11551359
    revision               = each.value.revision
  }
}

locals {
  project_id   = "ccba5035-0b8d-4989-8a7a-f20b93801074"
  revision     = "plugin-create-env"
  project_name = "dynamic-environments"
  environments = {
    dev-svc = {
      project_id        = local.project_id
      project_name      = local.project_name
      path              = "dynamic-environments/dev-svc"
      revision          = local.revision
    }
    dev-svc2 = {
      project_id        = local.project_id
      project_name      = local.project_name
      path              = "dynamic-environments/dev-svc2"
      revision          = local.revision
    }
  }
}