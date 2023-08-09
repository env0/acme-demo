package env0

#Helper
any_other_approver[i] {
  some j
  input.approvers[j].email != input.approvers[i].email
}

# METADATA
# title: separation of duties
# description: wait for secondary approval (deployer cannot be approver)
pending[msg] {
	count(input.approvers) == 0
	msg := sprintf("Separation of duties policy: '%v'(deployer) needs someone else to approve the deployment", [input.deployerUser.name])
}

# METADATA
# title: separation of duties
# description: wait for secondary approval (deployer cannot be approver)
pending[msg] {
  some i
  input.deployerUser.email == input.approvers[i].email
  not any_other_approver[i]
  msg := sprintf("Separation of duties policy: '%v'(deployer) needs someone else to approve the deployment", [input.deployerUser.name])
}

# METADATA
# title: separation of duties
# description: approver is not deployer 
allow[msg] {
	some i
	input.deployerUser.email != input.approvers[i].email
	msg := sprintf("Approved by: %v", [input.approvers[i].name])
}