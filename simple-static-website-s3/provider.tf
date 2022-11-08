terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }

  # scenario 1b use env0's remote backend. 
  backend "remote" {
    hostname = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.d80c9a87-2794-4f04-94fd-3fc675444073"

    workspaces {
      name = "static-website-dev1"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
