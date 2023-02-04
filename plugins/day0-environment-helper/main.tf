resource "env0_environment" "dynamic_environment" {
  for_each   = local.environments
  name       = each.key
  project_id = each.value.project_id
  //force_destroy = each.value.force_destroy
  force_destroy                    = true
  auto_deploy_on_path_changes_only = true
  deploy_on_push                   = true
  run_plan_on_pull_requests        = true

  without_template_settings {
    repository             = var.repository
    path                   = each.value.path
    type                   = "terraform"
    github_installation_id = 11551359
    revision               = each.value.revision
  }
}

locals {
  environments = {
    dev-svc = {
      project_id        = "7ded3097-2e6d-47af-81f3-00ee6b841e6d"
      path              = "dynamic-environments/dev-svc"
      revision          = "plugin-create-env"
      is_remote_backend = true
    }
    dev-svc2 = {
      project_id        = "7ded3097-2e6d-47af-81f3-00ee6b841e6d"
      path              = "dynamic-environments/dev-svc2"
      revision          = "plugin-create-env"
      is_remote_backend = true
    }
  }
}