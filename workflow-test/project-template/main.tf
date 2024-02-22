terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  api_key    = var.env0_api_key
  api_secret = var.env0_api_secret
}

resource "env0_project" "project" {
  name        = var.project_name
  description = "project created by TF"
  parent_project_id = var.parent_project_id
}
