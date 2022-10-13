data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.this.id

  tags = {
    tier = "private"
  }
}

module "efs" {
  source        = "git@github.com:env0/k8s-modules.git//aws/efs"
  region       = var.region
  vpc_id       = data.aws_vpc.this.id
  cluster_name = var.cluster_name
  subnets      = data.aws_subnet_ids.private.ids
}
