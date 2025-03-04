variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "group" {
  description = "Group identifier"
  type        = string
  default     = "default-group"
}

variable "roles" {
  description = "Map of roles and their policy ARNs"
  type = map(object({
    policy_arn = string
  }))
  default = {
    karpenter-node      = { policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" }
    karpenter-controller = { policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" }
  }
}
