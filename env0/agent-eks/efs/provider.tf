terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.68.0"
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
