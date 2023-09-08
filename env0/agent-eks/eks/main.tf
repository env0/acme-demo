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


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.16.0"

  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      preserve    = true
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = data.aws_vpc.this.id
  subnet_ids               = data.aws_subnets.private.ids
  control_plane_subnet_ids = data.aws_subnets.private.ids

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  # Create a new cluster where both an identity provider and Fargate profile is created
  # will result in conflicts since only one can take place at a time
  # # OIDC Identity provider
  # cluster_identity_providers = {
  #   sts = {
  #     client_id = "sts.amazonaws.com"
  #   }
  # }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = var.map_roles

}


module "eks_managed_node_group_blue" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "~> 19.16.0"

  name            = "${var.cluster_name}-eks-mng-blue"
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version

  subnet_ids                        = data.aws_subnets.private.ids
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.cluster_security_group_id,
  ]

  min_size     = 1
  max_size     = 3
  desired_size = 1

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