package env0

import future.keywords.in
import future.keywords.if
#####
# filename: cost-policy.rego
# purpose: restrict users from deploying over a certain amount of (estimated) cost.
# note: $30/month with cost_approvers hard_coded.
#####

format(meta) := meta.description

has_key(x, k) {
	_ = x[k]
}

allow if {
  cost.allow
}

allow if {
  noop.allow
}

pending[msg] {
  not allow  # all allow trumps pending
  cost.pending
  msg := sprintf("%v", [cost.pending])
}

## pending[message] if {
##   not allow
## }

## STATIC VARIABLES
# Cost Approvers
cost_approvers := ["kevin.damaso@env0.com", "andrew.way@env0.com", "chris.noon@env0.com"]
cost_limit := 10 # USD per month

# METADATA
# title: require approval on cost estimation
# description: require approval from cost_approvers if cost estimation is returning any value greater than $X/month on the plan
cost.pending if {
  input.costEstimation.totalMonthlyCost > cost_limit
  not any_approver_present
  #message := sprintf("require approval from cost_approvers if cost estimation is greater than $%v/month", [cost_limit])
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
cost.allow if {
  any_approver_present
}

any_approver_present {
  input.approvers[_].email == cost_approvers[_]
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: approve automatically if the estimated costs are less than $X/month
cost.allow if {
  input.costEstimation.totalMonthlyCost <= cost_limit 
  #message := sprintf("approve automatically if the estimated costs are less than $%v/month", [cost_limit])
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan no cost estimation
cost.allow if {
  not has_key(input, "costEstimation")
}

# METADATA
# title: allow if no changes
# description: approve automatically if the plan has no changes
noop.allow if {
  not any_resources_with_change
}

any_resources_with_change {
  input.plan.resource_changes[_].change.actions[_] != "no-op"
}
