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
