terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.68.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

/*
The following 2 data resources are used get around the fact that we have to wait
for the EKS cluster to be initialised before we can attempt to authenticate.
*/

data "aws_eks_cluster" "cluster" {
  name = "kmac-shag2"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "kmac-shag2"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}