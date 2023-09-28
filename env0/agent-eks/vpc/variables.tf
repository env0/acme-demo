variable "cluster_name" {
  type        = string
  description = "The name of the VPC related to the cluster"
  default     = "acme"
}

variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"

  default = "172.32.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets inside the VPC"

  default = ["172.32.0.0/19", "172.32.64.0/19", "172.32.128.0/19", "172.32.192.0/19"]
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets inside the VPC"

  default = ["172.32.32.0/19", "172.32.96.0/19", "172.32.160.0/19", "172.32.224.0/19"]
}

variable "instance_type" {
  type        = string
  description = "Instance type the EKS cluster is using. Needs to match aws/eks/variables.tf instance_type. Used to check which AZs support this instance type."
  default     = "t4g.large"
}

variable "region" {
  type    = string
  default = "us-west-2"
}