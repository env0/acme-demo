terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~>1.14.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~>3.75.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "=2.9.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.7.0"
    }
  }

  backend "remote" {
    hostname = "backend.api.env0.com"
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
  # exec {
  #   api_version = "client.authentication.k8s.io/v1alpha1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
  #   command     = "aws"
  # }
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # exec {
  #   api_version = "client.authentication.k8s.io/v1alpha1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
  #   command     = "aws"
  # }
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    # exec {
    #   api_version = "client.authentication.k8s.io/v1alpha1"
    #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    #   command     = "aws"
    # }
  }
}

variable "region" {
  type = string
  default = "us-west-2"
}

variable "cluster_name" {
  type = string
  default = "acme-fitness-cluster"
}

variable "cluster_exists" {
  type = bool
  default = true
}

module "env0-agent-eks" {
  source = "git@github.com:env0/k8s-modules.git//aws?ref=feat/dynamicazs"
  region = var.region
  cluster_name = var.cluster_name

  map_roles = [{"rolearn" = "arn:aws:iam::326535729404:role/env0-acme-assume-role",
                "groups" = ["system:masters"],
                "username"= "env0 deployer"},
               {"rolearn" = "arn:aws:sts::326535729404:assumed-role/AWSReservedSSO_AdministratorAccess_6e013e7aceaa4447",
                "groups" = ["system:masters"],
                "username"= "env0 employee"}]

  // us-west-2 only has four AZs so reduce subnets to 4
  private_subnets = ["172.16.0.0/21", "172.16.16.0/21", "172.16.32.0/21", "172.16.48.0/21"]
  public_subnets  = ["172.16.8.0/22", "172.16.24.0/22", "172.16.40.0/22", "172.16.56.0/22"]
}