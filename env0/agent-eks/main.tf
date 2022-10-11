terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

// providers.tf
provider "aws" {
  region = var.region
}


data "aws_eks_cluster" "cluster" {
  name = module.env0-agent-eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.env0-agent-eks.cluster_id
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
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

module "env0-agent-eks" {
  source = "git@github.com:env0/k8s-modules.git//aws?ref=feat/dynamicazs"
  region = var.region
  cluster_name = var.cluster-name
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "cluster-name" {
  type = string
  default = "env0 agent eks"
}

