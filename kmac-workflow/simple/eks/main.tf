data "aws_vpc" "kmac-workflow" {
  tags = {
    Name = "vpc-kmac-workflow"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.kmac-workflow.id

  tags = {
    tier = "private"
  }
}

module "eks" {
  source                    = "terraform-aws-modules/eks/aws"
  version                   = "17.24.0"
  cluster_name              = var.cluster_name
  cluster_version           = "1.23"
  vpc_id                    = data.aws_vpc.kmac-workflow.id
  subnets                   = data.aws_subnet_ids.private.ids
  enable_irsa               = true
  cluster_enabled_log_types = ["api", "scheduler", "controllerManager"]

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  workers_group_defaults = {
    protect_from_scale_in = true
  }

  node_groups = {
    deployment = {
      name             = "${var.cluster_name}-deployment-node-group"
      desired_capacity = var.min_capacity
      max_capacity     = 50
      min_capacity     = var.min_capacity

      instance_types = [var.instance_type]
      capacity_type  = "SPOT"
    }
  }

  write_kubeconfig = var.write_kubeconfig

  map_roles    = var.map_roles
  map_users    = []
  map_accounts = []
}