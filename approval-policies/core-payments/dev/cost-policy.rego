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
cost_approvers := ["andrew.way@env0.com", "asaf.blubshtein@env0.com"]
cost_limit := 10 # USD per month

# METADATA
# title: require approval on cost estimation
# description: require approval from cost_approvers if cost estimation is returning any value greater than $30/month on the plan
pending[message] {
  input.costEstimation.monthlyCostDiff != 0
  input.costEstimation.totalMonthlyCost > cost_limit
  not any_approver_present
  message := sprintf("FINOPS RULE 2: require approval from cost_approvers if cost estimation is greater than $%v/month", [cost_limit])
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
allow[format(rego.metadata.rule())] {
  any_approver_present
}

any_approver_present {
  input.approvers[_].email == cost_approvers[_]
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: approve automatically if the estimated costs are less than $10/month
allow[format(rego.metadata.rule())] {
  input.costEstimation.totalMonthlyCost <= cost_limit 
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan no cost estimation
allow[format(rego.metadata.rule())] {
  not has_key(input, "costEstimation")
}
