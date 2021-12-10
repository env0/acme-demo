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
  source  = "api.env0.com/c89e9161-8350-44a5-81cf-9eb26605e195/project/env0"
  version = "0.1.1"

  projects = var.projects
}

variable "projects" {
  type = map(
    object({
      name        = string
      description = string
      credential  = string
      policy = object({
        continuous_deployment_default = bool
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
