terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_count" {
  type    = number
  default = 1
}

resource "random_string" "bucket_suffix" {
  count   = var.bucket_count
  length  = 8
  upper   = false
  special = false
}

resource "aws_s3_bucket" "example" {
  count  = var.bucket_count
  bucket = "opentofu-bucket-${random_string.bucket_suffix[count.index].result}"

  tags = {
    Name        = "OpenTofu Example Bucket ${count.index}"
    Environment = "Dev"
  }
}
