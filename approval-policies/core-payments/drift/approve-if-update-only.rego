package env0


allow[msg] {
  count(input.approvers) >= 1
}
# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[msg] {
  not any_resources_with_deletion
  not any_resources_with_creation
  msg := "approve automatically for updates only"
}

any_resources_with_updates {
  input.plan.resource_changes[_].change.actions[_] == "update"
}

any_resources_with_deletion {
  input.plan.resource_changes[_].change.actions[_] == "destroy"
}

any_resources_with_creation {
  input.plan.resource_changes[_].change.actions[_] == "create"
}
