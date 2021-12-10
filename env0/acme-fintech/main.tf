terraform {
}

module "project" {
  source  = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/project/env0"
  version = "v0.0.1"

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


