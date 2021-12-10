terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.20"
    }
  }
}

provider "env0" {
}

module "project" {
  source = "api.env0.com/c89e9161-8350-44a5-81cf-9eb26605e195/project/env0"
  version = "0.0.2"

  projects = {
    dev0 = {
      name        = "Team A - Dev"
      description = "Team A's Dev Instance"
    }
    dev1 = {
      name        = "Team B - Dev"
      description = "Team B's Dev Instance"
    }
    dev2 = {
      name        = "Team C - Prod"
      description = "Team C's Dev Instance"
    }
  }

  policy = {
    disable_destroy_environments  = false
    include_cost_estimation       = true
    number_of_environments        = "3"
    number_of_environments_total  = "10"
    requires_approval_default     = false
    skip_apply_when_plan_is_empty = true
    skip_redundant_deployments    = true
    continuous_deployment_default = true
    run_pull_request_plan_default = false
  }
}

