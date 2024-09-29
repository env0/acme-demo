package env0

# METADATA
# title: require 1 approval
# description: At least 1 approval must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: more than 1 approvals
# description: allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description
