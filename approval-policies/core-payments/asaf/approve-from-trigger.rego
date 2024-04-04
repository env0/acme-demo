package env0

# METADATA
# title: Require Approval
# description: require 1 approval
pending[format(rego.metadata.rule())] {
	not input.deploymentRequest.triggerName == "workflow"
	count(input.approvers) == 0
}

# METADATA
# title: Allow if got approved
# description: approved

allow[format(rego.metadata.rule())] {
  input.deployerUser.name == "env0"
  input.deploymentRequest.triggerName == "workflow"
}

allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description
