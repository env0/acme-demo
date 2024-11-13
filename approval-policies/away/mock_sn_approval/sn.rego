package env0

# METADATA
# title: separation of duties
# description: approver is not deployer 
allow[msg] {
  count(input.approvers) > 1
  msg := "multiple approvers"
}

# METADATA
# title: CD Triggers
# description: if CD trigger, wait for approval. 
pending[msg] {
  count(input.approvers) < 2
  msg := "need two approvers"
}

pending[msg] {
  count(input.approvers) == 1
  msg := sprintf("current approver: %v, %v", [input.approvers[0].name, input.approvers[0].email])
}
