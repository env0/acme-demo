#####
# filename: cost-policy.rego
# purpose: restrict users from deploying over a certain amount of (estimated) cost.
# note: $30/month with cost_approvers hard_coded.
#####

package env0

format(meta) := meta.description

has_key(x, k) {
  _ = x[k]
}

## STATIC VARIABLES
# Cost Approvers
cost_approvers := "539edd93-be20-46e8-91f4-3c020d15e9d9"  # Cost Approvers
cost_limit := 15 # USD per month

# METADATA
# title: require approval on cost estimation
# description: require approval from cost_approvers if cost estimation is returning any value greater than $15/month on the plan
pending[message] {
  input.costEstimation.monthlyCostDiff != 0
  input.costEstimation.totalMonthlyCost > cost_limit
  not any_approver_present
  message := sprintf("FINOPS RULE 2: require approval from cost_approvers if cost estimation is greater than $%v/month", [cost_limit])
}

warn[message] {
  input.costEstimation.totalMonthlyCost > (2 * cost_limit)
  message := sprintf("FINOPS RULE 2b: warning: cost estimation exceeded by 200%% of cost limit $%v/month", [cost_limit]) 
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
allow[format(rego.metadata.rule())] {
  any_approver_present
}

any_approver_present {
  input.approvers[_].teams[_].id == cost_approvers
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: approve automatically if the estimated costs are less than $15/month
allow[format(rego.metadata.rule())] {
  input.costEstimation.totalMonthlyCost <= cost_limit 
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan no cost estimation
allow[format(rego.metadata.rule())] {
  not has_key(input, "costEstimation")
}
