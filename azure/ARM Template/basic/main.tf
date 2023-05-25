locals {
  arm_plan = file(azuredeploy.plan.json)
}

output "arm_plan" {
  value = local.arm_plan
}