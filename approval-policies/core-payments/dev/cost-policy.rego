package env0

has_key(x, k) {
	_ = x[k]
}

## METADATA
## title: deny on over spend
## description: automatically deny when cost estimation is returning any value greater than $30/month on the plan
#deny[format(rego.metadata.rule())] {
#  input.costEstimation.totalMonthlyCost > 30
#}

cost_approvers = ["kevin.damaso@env0.com", "andrew.way@env0.com", "chris.noon@env0.com"]

# METADATA
# title: require approval on cost estimation
# description: require approval from cost_approvers if cost estimation is returning any value greater than $30/month on the plan
pending[format(rego.metadata.rule())] {
  input.approvers[_].email != cost_approvers[_]
  input.costEstimation.totalMonthlyCost > 30
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
allow[format(rego.metadata.rule())] {
  input.approvers[_].email == cost_approvers[_]
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: approve automatically if the estimated costs are less than $30/month
allow[format(rego.metadata.rule())] {
  input.costEstimation.totalMonthlyCost <= 30
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan no cost estimation
allow[format(rego.metadata.rule())] {
	not has_key(input, "costEstimation")
}

format(meta) := meta.description
