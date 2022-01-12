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
  project_policy_dev = {
      "continuous_deployment_default" = true
      "disable_destroy_environments" = false
      "include_cost_estimation" = true
      "number_of_environments" = "3"
      "number_of_environments_total" = "10"
      "requires_approval_default" = "false"
      "run_pull_request_plan_default" = false
      "skip_apply_when_plan_is_empty" = true
      "skip_redundant_deployments" = true
  }

  projects = {
    "core payments - dev" = {
      description            = "Core Payments - Dev Project"
      project_policy         = local.project_policy_dev
    }
  }
}

resource "env0_project" "project" {
  for_each = 
}