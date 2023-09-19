data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

data "aws_subnets" "private" {
  filter {
      name = "vpc-id"
      values = [data.aws_vpc.this.id]
  }

  tags = {
    tier = "private"
  }
}

module "eks_managed_node_group_blue" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "~> 19.16.0"

  name            = "${var.cluster_name}-eks-mng-blue"
  cluster_name    = module.eks.cluster_name
  #cluster_version = module.eks.cluster_version

  subnet_ids                        = data.aws_subnets.private.ids
  #cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.cluster_security_group_id,
  ]

  min_size     = var.min_capacity
  max_size     = var.min_capacity + 2
  desired_size = var.min_capacity

  ami_type       = "BOTTLEROCKET_x86_64"
  platform       = "bottlerocket"
  capacity_type  = "SPOT"
  instance_types = [var.instance_type]

  # this will get added to what AWS provides
  bootstrap_extra_args = <<-EOT
    # extra args added
    [settings.kernel]
    lockdown = "integrity"

    [settings.kubernetes.node-labels]
    "label1" = "foo"
    "label2" = "bar"
  EOT

  tags = { Separate = "eks-managed-node-group" }
}