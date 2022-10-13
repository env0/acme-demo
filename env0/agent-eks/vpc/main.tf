module "vpc" {
  source = "git@github.com:env0/k8s-modules.git//aws/vpc?ref=feat/vpc-dynamic-azs"

  cluster_name    = var.cluster_name
  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}