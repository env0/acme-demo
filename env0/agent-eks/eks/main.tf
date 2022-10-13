data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    tier = "private"
  }
}

data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

module "eks" {
  source     = "git@github.com:env0/k8s-modules.git//aws/vpc?ref=feat/vpc-dynamic-azs"
  vpc_id        = data.aws_vpc.this.id
  cluster_name  = var.cluster_name
  map_roles     = var.map_roles
  min_capacity  = var.min_capacity
  instance_type = var.instance_type
}
