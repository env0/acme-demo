variable "cluster_name" {
  default = "kmac-workflow"
}

variable "cidr" {
  description = "The CIDR block for the VPC"

  default = "172.16.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnets inside the VPC"
  default     = ["172.16.0.0/21", "172.16.16.0/21"]
}

variable "public_subnets" {
  description = "List of public subnets inside the VPC"
  default     = ["172.16.8.0/22", "172.16.24.0/22"]
}

variable "instance_type" {
  description = "Instance type the EKS cluster is using. Needs to match aws/eks/var.tf instance_type. Used to check which AZs suport this instance type"
  default     = "t3a.2xlarge"
}