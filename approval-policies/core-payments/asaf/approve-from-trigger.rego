package env0

# METADATA
# title: Require Approval
# description: require 1 approval

allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

# METADATA
# title: Allow if got approved
# description: approved

allow[format(rego.metadata.rule())] {
  input.deployerUser.name == "env0"
  input.deploymentRequest.triggerName == "workflow"
}

format(meta) := meta.description
