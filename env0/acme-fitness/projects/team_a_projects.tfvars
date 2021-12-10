projects = {
  dev0 = {
    name        = "Arnold's Dev Team"
    description = "T2000 is back for more exciting Infrastructure as Code work"
    credential  = "DevOps Advocate account"
    policy = {
      disable_destroy_environments  = false
      include_cost_estimation       = true
      number_of_environments        = "3"
      number_of_environments_total  = "10"
      requires_approval_default     = true
      skip_apply_when_plan_is_empty = true
      skip_redundant_deployments    = true
      continuous_deployment_default = true
      run_pull_request_plan_default = false
    }
  },
  prod0 = {
    name        = "Arnold's Prod Team"
    description = "T2000 is back for more exciting Infrastructure as Code work"
    credential  = "Prod Demo Account"
    policy = {
      disable_destroy_environments  = true
      include_cost_estimation       = true
      number_of_environments        = null
      number_of_environments_total  = null
      requires_approval_default     = true
      skip_apply_when_plan_is_empty = true
      skip_redundant_deployments    = true
      continuous_deployment_default = true
      run_pull_request_plan_default = true
    }
  }
}

