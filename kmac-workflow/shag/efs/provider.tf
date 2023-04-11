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

