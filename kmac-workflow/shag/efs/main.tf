data "aws_vpc" "kmac-shag2" {
  tags = {
    Name = "vpc-kmac-shag2"
  }
}

data "aws_eks_cluster" "cluster" {
  name = "kmac-shag2"
}


data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.kmac-shag2.id

  tags = {
    tier = "private"
  }
}

module "efs" {
  depends_on = [data.aws_eks_cluster.cluster]

  source  = "cloudposse/efs/aws"
  version = "0.31.1"

  region  = var.region
  vpc_id  = data.aws_vpc.kmac-shag2.id
  subnets = data.aws_subnet_ids.private.ids

  transition_to_ia = "AFTER_7_DAYS"

  tags = {
    Name = "kmac-shag2-state-efs"
  }

  security_group_rules = [
    {
      type                     = "ingress"
      from_port                = 2049
      to_port                  = 2049
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = data.aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
      description              = "Allow ingress traffic to EFS from primary EKS security group"
    }
  ]
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = module.efs.id

  backup_policy {
    status = "ENABLED"
  }
}
