variable "region" {
  type    = string
  default = "us-west-2"
}

variable "cluster_name" {
  type    = string
  default = "acme"
}

# example usage
# map_roles = [{"rolearn" = "arn:aws:iam::326535729404:role/env0-acme-assume-role",
#               "groups" = ["system:masters"],
#               "username"= "env0 deployer"},
#              {"rolearn" = "arn:aws:iam::326535729404:role/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447",
#               "groups" = ["system:masters"],
#               "username"= "env0 employee"}]
variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = [
    {
      "rolearn"  = "arn:aws:iam::326535729404:role/env0-acme-assume-role",
      "groups"   = ["system:masters"],
      "username" = "env0 deployer"
    },
    {
      "rolearn"  = "arn:aws:iam::326535729404:role/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447",
      "groups"   = ["system:masters"],
      "username" = "env0 employee"
    }
  ]
}

variable "kms_key_administrators" {
  type = list(string)
  default = ["arn:aws:iam::326535729404:role/env0-acme-assume-role",
  "arn:aws:iam::326535729404:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447"]
}

variable "min_capacity" {
  description = "Min number of workers"
  default     = 1
}

variable "instance_types" {
  type    = list(string)
  default = ["t3a.large"]
}