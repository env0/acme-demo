terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = ">= 1.0.0"
    }
  }
}

variable "project" {
  type = string
}

variable "name" {
  type = string
}

variable "force_destroy" {
  type = bool
  default = false
}

data "env0_project" "project" {
  name = var.project
}

resource "env0_environment" "infra-base" {
  name                       = "infra-base-${var.name}"
  project_id                 = data.env0_project.project.id
  template_id                = "84727784-587b-4e58-83ea-b0e2f9c872bd"
  approve_plan_automatically = true
  force_destroy              = var.force_destroy
  wait_for                   = "FULLY_DEPLOYED"
}

resource "env0_environment" "infra-mid" {
  name                       = "infra-mid-${var.name}"
  project_id                 = data.env0_project.project.id
  template_id                = "8c86ee3e-c42d-4f7b-b7be"-8513f20fcc65""
  approve_plan_automatically = true
  force_destroy              = var.force_destroy
  wait_for                   = "FULLY_DEPLOYED"
  depends_on                 = [env0_environment.infra-base]
}

resource "env0_environment" "infra-top" {
  name                       = "infra-top-${var.name}"
  project_id                 = data.env0_project.project.id
  template_id                = "5cfcb877-bdf2-402f-a5fc-343d2e1a8f8e"
  approve_plan_automatically = true
  force_destroy              = var.force_destroy
  depends_on                 = [env0_environment.infra-mid]
}

resource "env0_workflow_triggers" "base-mid" {
  environment_id = env0_environment.infra-base.id
  downstream_environment_ids = [
    env0_environment.infra-mid.id
  ]
}

resource "env0_workflow_triggers" "mid-top" {
  environment_id = env0_environment.infra-mid.id
  downstream_environment_ids = [
    env0_environment.infra-top.id
  ]
}
