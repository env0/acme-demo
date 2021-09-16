terraform {
  required_version = "~>0.15.4"
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "3.41.0"
    # }
    vault = {
      source = "hashicorp/vault"
      version = "2.22.1"
    }
  }
}

# provider "aws" {
#   region = "us-west-2"
# }

provider "vault" {
}