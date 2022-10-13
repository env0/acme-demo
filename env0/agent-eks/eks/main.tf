data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

module "eks" {
  source           = "git@github.com:env0/k8s-modules.git//aws/eks?ref=feat/kubeconfig-option"
  vpc_id           = data.aws_vpc.this.id
  cluster_name     = var.cluster_name
  map_roles        = var.map_roles
  min_capacity     = var.min_capacity
  instance_type    = var.instance_type
  write_kubeconfig = false
}
