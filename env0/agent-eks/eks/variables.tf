variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
  description = "The id of the specific VPC to using"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)

  # e.g.
  # map_roles = [{"rolearn" = "arn:aws:iam::326535729404:role/env0-acme-assume-role",
  #               "groups" = ["system:masters"],
  #               "username"= "env0 deployer"},
  #              {"rolearn" = "arn:aws:sts::326535729404:assumed-role/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447",
  #               "groups" = ["system:masters"],
  #               "username"= "env0 employee"}]
  # }))

  default = []
}

variable "min_capacity" {
  description = "Min number of workers"
  default = 2
}

variable "instance_type" {
  default = "t3a.2xlarge" # 8vCPUs 32GB
}