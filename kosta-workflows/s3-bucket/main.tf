resource "aws_s3_bucket" "kosta-bucket" {
  bucket = var.bucket_name
}

provider "aws" {
    region = "us-east-1"
}