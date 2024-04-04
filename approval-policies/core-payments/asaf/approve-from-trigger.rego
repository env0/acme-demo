allow[msg] {
  input.deployerUser.name == "env0"
  input.deploymentRequest.triggerName = "workflow"
  msg := "approve automatically, no resources changed"
}
