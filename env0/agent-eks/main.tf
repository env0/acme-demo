module "env0-agent-eks" {
  source = "git@github.com:env0/k8s-modules.git//aws"

  region = var.region
} 

variable "region" {
  type = string
  default = "us-east-1"
}

variable "cluster-name" {
  type = string
  default = "env0 agent eks"
}