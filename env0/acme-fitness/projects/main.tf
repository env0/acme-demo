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
      description = "Team A's Dev Instance (managed by !env0 Master , env0 Project)"
      policy      = local.dev_policy
    }
    prod0 = {
      name        = "Team A - Prod"
      description = "Team A's Prod Instance (managed by !env0 Master , env0 Project)"
      policy      = local.prod_policy
    }
    dev2 = {
      name        = "Team C - Dev"
      description = "Team C's Dev Instance (managed by !env0 Master , env0 Project)"
    }
  }
}

variable "projects" {
  type = map(
    object({
      name        = string
      description = string
      policy = object({
        continuous_deployment_default = optional(bool)
        disable_destroy_environments  = bool
        include_cost_estimation       = bool
        number_of_environments        = string
        number_of_environments_total  = string
        requires_approval_default     = bool
        run_pull_request_plan_default = bool
        skip_apply_when_plan_is_empty = bool
        skip_redundant_deployments    = bool
      })
    })
  )
  description = "map of object with names and descriptions e.g. {dev0={name=\"dev\",description=\"this is my dev project\",policy=local.devpolicy}}"
}
