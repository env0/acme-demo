variable "cluster_name" {
  default = "kmac-shag2"
}

variable "instance_type" {
  default = "t3a.2xlarge" #8vCPUs 32GB
}

variable "min_capacity" {
  description = "Min number of workers"
  default     = 2
}

variable "write_kubeconfig" {
  type    = bool
  default = false
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
