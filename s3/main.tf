terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "bucketname" {
  type    = string
  default = "env0-acme-bucket"
}

variable "app_tag" {
  type    = string
  default = "application tag"
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  numeric  = true
}

module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.0"

  bucket = "${var.bucketname}-${random_string.random.id}"

  tags = {
    App = var.app_tag
  }
}
  
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}
