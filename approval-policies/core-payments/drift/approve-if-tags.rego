package env0

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[msg] {
  not any_resources_with_change
  msg := "approve automatically, no resources changed"
}

any_resources_with_in_place {
  input.plan.resource_changes[_].change.actions[_] == "in-place"
}