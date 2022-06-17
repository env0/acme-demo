terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }

  backend "s3" {} 
}


provider "aws" {
  region = "us-west-2"
}