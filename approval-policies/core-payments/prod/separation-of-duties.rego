package env0

format(meta) := meta.description

# Helper
any_other_approver[i] {
  input.approvers[j].email != input.approvers[i].email
  i != j
}

# METADATA
# title: separation of duties
# description: wait for secondary approval (deployer cannot be approver)
pending[format(rego.metadata.rule())] {
  some i
  input.deployerUser.email == input.approvers[i].email
  not any_other_approver[i]
}

# METADATA
# title: separation of duties
# description: approver is not deployer 
allow[reason] {
  some i
  input.deployerUser.email != input.approvers[i].email
  reason = fmt.Printf("approver (%s)", input.approvers[i].email)
}
