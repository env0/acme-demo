projects = {
  teama = {
    name        = "Team Acme"
    description = "Team Acme"
    team_role_assignments = [
      {
        team_name = "Managers"
        role      = "Admin"
      },
    ]
    sub_projects = {
      dev = {
        name        = "Team A - Dev"
        description = "Team A's Dev Instance"
        credential  = "aws-244172364962-dev"
        team_role_assignments = [
          {
            team_name = "Managers"
            role      = "Admin"
          },
          {
            team_name = "Developers"
            role      = "Deployer"
          }
        ]
        policy = {
          "disable_destroy_environments"  = false
          "include_cost_estimation"       = true
          "number_of_environments"        = "3"
          "number_of_environments_total"  = "10"
          "requires_approval_default"     = false
          "skip_apply_when_plan_is_empty" = true
          "skip_redundant_deployments"    = true
          "continuous_deployment_default" = true
          "run_pull_request_plan_default" = false
          "default_ttl"                   = "1-d"
          "max_ttl"                       = "1-w"
        }
      }
      qa = {
        name        = "Team A - QA"
        description = "Team B's Dev Instance"
        credential  = "aws-244172364962-dev"
        team_role_assignments = [
          {
            team_name = "Managers"
            role      = "Admin"
          },
          {
            team_name = "Developers"
            role      = "Deployer"
          }
        ]
      }
      prod = {
        name        = "Team A - Prod"
        description = "Team A's Prod Instance"
        team_role_assignments = [
          {
            team_name = "Managers"
            role      = "Admin"
          },
          {
            team_name = "Developers"
            role      = "Planner"
          }
        ]
        policy = {
          "disable_destroy_environments" = true
          "requires_approval_default"    = true
        }
      }
    }
  }
}
