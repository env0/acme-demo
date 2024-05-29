variable "length" {
  type    = number
  default = 15
}

variable "refresh_token" {
  type    = string
  default = "0"
}

variable "numeric" {
    type  = bool
    default = false
}

# sub_environment_configuration {
#   alias = "workload-kubernetes-addon-argo-rollouts"
#   revision = var.revision

#   configuration {
#     type = "environment"
#     name = "ENVO_TERRAFORM_CONFIG_FILE_PATH"
#     value = "../../../../../live/${var.environment}/${each.value.name}/platform/workload/kubernetes/addons/argo-rollouts/terraform.tfvars"
#     is_required = true
#   }

#   configuration {
#     type = "terraform"
#     name = "oidc_provider_arn"
#     value = "$${env0-workflow: workload-kubernetes-cluster:oidc_provider_arn}"
#     is_required = true
#   }

#   configuration {
#     type = "terraform"
#     name = "cluster_name"
#     value = "$${env0-workflow: workload-kubernetes-cluster: cluster_name}"
#     is_required = true
#   }

# }