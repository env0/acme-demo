package env0

format(meta) := meta.description

# METADATA
# title: separation of duties
# description: wait for approval if no other approver is present
pending[format(rego.metadata.rule())] {
  some i
  input.deployerUser.email == input.approvers[i].email
  not any_other_approver[i]
}

any_other_approver[i] {
  input.approvers[j].email != input.approvers[i].email
  i != j
}
