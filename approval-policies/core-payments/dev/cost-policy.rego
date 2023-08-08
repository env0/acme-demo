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

any_approver_present {
  input.approvers[_].email == cost_approvers[_]
}

# METADATA
# title: require approval on cost estimation
# description: require approval from cost_approvers if cost estimation is returning any value greater than $30/month on the plan
pending[format(rego.metadata.rule())] {
  input.costEstimation.totalMonthlyCost > 30
  not any_approver_present
}

# METADATA
# title: require secondary approver
# description: wait for approval if deployer is a member of the approver list and no other approver is present
pending[format(rego.metadata.rule())] {
  some i
  input.deployerUser.email == approvers[i].email
  not any_other_approver[i]
}

any_other_approver[i] {
  input.approvers[j].email == approvers[i].email
  i != j
}

# METADATA
# title: allow if approved by anyone else other than deployer
# description: deployment can be approved by someone other than deployer
allow[format(rego.metadata.rule())] {
  any_approver_present
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

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[format(rego.metadata.rule())] {
	input.plan.resource_changes[_].change[_] == "no-op"
}

format(meta) := meta.description

review_plan = input.plan
