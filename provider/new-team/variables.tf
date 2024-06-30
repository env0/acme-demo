variable "env0_api_key" {
  description = "API key for env0"
  type        = string
}

variable "env0_api_secret" {
  description = "API secret for env0"
  type        = string
}

variable "team_name" {
  description = "Name of the team"
  type        = string
  default     = "Skunkworks"
}

variable "team_environments" {
  description = "List of team environments"
  type        = list(string)
  default     = [ "Dev", "Stage", "Prod" ]
}

variable "policies" {
  description = "Policies in JSON format"
  type        = map(any)
  default     = {
    Dev = {
      number_of_environments        = 1
      number_of_environments_total  = 1
      requires_approval_default     = true
      include_cost_estimation       = true
      skip_apply_when_plan_is_empty = true
      disable_destroy_environments  = true
      skip_redundant_deployments    = true
    }
    Stage = {
      number_of_environments        = 2
      number_of_environments_total  = 2
      requires_approval_default     = false
      include_cost_estimation       = true
      skip_apply_when_plan_is_empty = false
      disable_destroy_environments  = true
      skip_redundant_deployments    = false
    }
    Prod = {
      number_of_environments        = 3
      number_of_environments_total  = 3
      requires_approval_default     = true
      include_cost_estimation       = true
      skip_apply_when_plan_is_empty = true
      disable_destroy_environments  = true
      skip_redundant_deployments    = true
    }
  }
}
