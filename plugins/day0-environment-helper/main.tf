resource "env0_environment" "example_with_hcl_configuration" {
  for_each = local.environments
  name        = each.key
  project_id  = each.value.project_id
  //force_destroy = each.value.force_destroy
  force_destroy = true

  without_template_settings {
    repository = var.repository
    repository             = "https://github.com/env0/acme-demo"
    path                   = each.value.path
    type                   = "terraform"
    github_installation_id = 11551359
  }
}

locals {
  environments = {
    project_id = "7ded3097-2e6d-47af-81f3-00ee6b841e6d"
    path = "dynamic-environments/dev-svc"
  }
}