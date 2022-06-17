terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.19"
    }
  }
}

provider "env0" {
}


locals {
  templates = {
    "my tf random" = {
      description            = "Random String Template created from TF Provider"
      repository             = "https://github.com/env0/acme-demo"
      path                   = "simple-terraform"
      type                   = "terraform"
      github_installation_id = 11551359
      project_ids            = ["6de20c9c-e5a2-49a3-aee5-00c03204ec3a"]
    }
  }
}


resource "env0_template" "template" {
  for_each = local.templates

  name                                     = each.key
  description                              = each.value.description
  repository                               = each.value.repository
  path                                     = each.value.path
  type                                     = each.value.type
  github_installation_id                   = each.value.github_installation_id
  revision                                 = "main"
  terraform_version                        = "1.0.11"
  retries_on_deploy                        = null
  retries_on_destroy                       = null
  retry_on_deploy_only_when_matches_regex  = null
  retry_on_destroy_only_when_matches_regex = null
  ssh_keys                                 = []
  token_id                                 = ""
}

module "template_project_helper" {
  source = "../module/template_project_helper"

  for_each = env0_template.template

  template_id = each.value.id
  project_ids = local.templates[each.value.name].project_ids
}