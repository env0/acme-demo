package env0

format(meta) := meta.description

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[format(rego.metadata.rule())] {
  not any_resources_with_change
}

any_resources_with_change {
  input.plan.resource_changes[_].change.actions[_] != "no-op"
}