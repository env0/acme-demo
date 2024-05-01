terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.0"
    }
  }
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "bucketname" {
  type    = string
  default = "env0-acme-bucket"
}

provider "aws" {
  region = var.region
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  number  = true
}

module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.0.0"

  bucket = "${var.bucketname}-${random_string.random.id}"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
}
  
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}
