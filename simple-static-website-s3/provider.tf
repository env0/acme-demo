terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }

  # scenario 1 no backend defined. 
}

provider "aws" {
  region = "us-west-2"
}
