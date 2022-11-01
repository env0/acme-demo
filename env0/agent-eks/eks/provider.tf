terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=>3.68.0"
    }
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"

    workspaces {
      prefix = "acme-fitness-agent-"
    }
  }
}

// providers.tf
provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
