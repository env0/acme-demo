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
  description = "List of roles with their policy ARNs"
  type = list(object({
    name       = string
    policy_arn = string
  }))
  default = [
    { name = "karpenter-node", policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" },
    { name = "karpenter-controller", policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" }
  ]
}

