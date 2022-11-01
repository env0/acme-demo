variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
}

# example usage
# map_roles = [{"rolearn" = "arn:aws:iam::326535729404:role/env0-acme-assume-role",
#               "groups" = ["system:masters"],
#               "username"= "env0 deployer"},
#              {"rolearn" = "arn:aws:sts::326535729404:assumed-role/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447",
#               "groups" = ["system:masters"],
#               "username"= "env0 employee"}]
# }))
variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "min_capacity" {
  description = "Min number of workers"
  default     = 2
}

#variable "instance_type" {
#  default = "t3a.2xlarge" # 8vCPUs 32GB
#}

variable "blue_instance_type" {
  default = "t3a.2xlarge" # 8vCPUs 32GB
}

variable "green_instance_type" {
  default = "" # 8vCPUs 32GB
}