# resource "null_resource" "arm_plan" {
#   triggers = {
#     base64_arm_plan = base64encode(file("azuredeploy.plan.json"))
#   }
# }
output "arm_plan" {
  value = file("azuredeploy.plan.json"se)
}