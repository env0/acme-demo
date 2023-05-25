locals {
  arm_plan = file(azuredeploy.plan.json)
}

resource "null_resource" "arm_plan" {
  triggers = {
    base64_arm_plan = base64encode(arm_plan)
  }
}

output "arm_plan" {
  value = local.arm_plan
}