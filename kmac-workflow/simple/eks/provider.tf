terraform {
  required_version = ">=1.0.0"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~>3.68.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.18.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9"
    }
  }
}

provider "aws" {
  region = "us-east-2"
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
