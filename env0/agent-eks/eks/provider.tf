terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.1a433171-217e-4f58-9b4e-308d4d77902f"

    workspaces {
      prefix = "acme-cluster-"
    }
  }
}

// providers.tf
provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
