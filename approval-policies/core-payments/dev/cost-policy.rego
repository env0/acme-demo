package env0

has_key(x, k) {
	_ = x[k]
}

# METADATA
# title: require approval on cost estimation
# description: require approval if cost estimation is returning any value greater than $10/month on the plan
pending[format(rego.metadata.rule())] {
  input.costEstimation.totalMonthlyCost > 30
  input.approvers[_].name == input.deployerUser.name
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
allow[format(rego.metadata.rule())] {
  input.approvers[_].name != input.deployerUser.name
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