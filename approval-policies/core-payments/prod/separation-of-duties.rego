package env0

# METADATA
# title: separation of duties
# description: approver is not deployer 
allow[msg] {
	some i
	input.deployerUser.email != input.approvers[i].email
	msg := sprintf("RULE 42: Approved by: %v", [input.approvers[i].name])
}

allow[msg] {
	input.deployerUser.name == "env0"
  count(input.approvers) > 0
  msg := sprintf("RULE 88b: Automated Deployment Approved by: %v", [input.approvers[0].name])
}

# METADATA
# title: CD Triggers
# description: if CD trigger, wait for approval. 
pending[msg] {
	input.deployerUser.name == "env0"
	msg := "RULE 88: Wait for Approval on Automated Deployment"
}
