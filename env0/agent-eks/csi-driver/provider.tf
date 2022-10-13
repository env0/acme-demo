terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~>1.14.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.75.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.9.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.0"
    }
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.1a433171-217e-4f58-9b4e-308d4d77902f"

    workspaces {
      name = "acme-fitness-eks"
    }
  }
}

// providers.tf
provider "aws" {
  region = var.region
}


data "aws_eks_cluster" "cluster" {
  name = var.cluster_exists ? var.cluster_name : module.env0-agent-eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_exists ? var.cluster_name : module.env0-agent-eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
