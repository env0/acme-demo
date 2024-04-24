data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
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

  # to get a list of addons run `aws eks describe-addon-versions`
  cluster_addons = {
    coredns = {
      # preserve    = true
      most_recent = true

      # timeouts = {
      #   create = "25m"
      #   delete = "10m"
      # }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = data.aws_vpc.this.id
  subnet_ids               = data.aws_subnets.private.ids
  control_plane_subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.instance_types
  }


  eks_managed_node_groups = {
    # Default node group - as provided by AWS EKS using Bottlerocket
    bottlerocket_blue = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      use_custom_launch_template = false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"
      desired_size = 2
    }

    # bottlerocket_green = {
    #   use_custom_launch_template = false

    #   ami_type = "BOTTLEROCKET_ARM_64"
    #   platform = "bottlerocket"
    # }
  }

  # # Extend cluster security group rules
  # cluster_security_group_additional_rules = {
  #   ingress_nodes_ephemeral_ports_tcp = {
  #     description                = "Nodes on ephemeral ports"
  #     protocol                   = "tcp"
  #     from_port                  = 1025
  #     to_port                    = 65535
  #     type                       = "ingress"
  #     source_node_security_group = true
  #   }
  # }

  # # Extend node-to-node security group rules
  # node_security_group_additional_rules = {
  #   ingress_self_all = {
  #     description = "Node to node all ports/protocols"
  #     protocol    = "-1"
  #     from_port   = 0
  #     to_port     = 0
  #     type        = "ingress"
  #     self        = true
  #   }
  # }

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
  aws_auth_roles            = var.map_roles

  kms_key_administrators = var.kms_key_administrators
}
