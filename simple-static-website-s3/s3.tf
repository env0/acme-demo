resource "random_string" "random" {
  length  = 7
  special = false
  lower   = true
  upper   = false
  numeric = true
}

module "acme-s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.11.0"

  bucket = "${var.bucketname}-${random_string.random.id}"

  acl                      = "public-read"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  block_public_acls        = false
  block_public_policy      = false
  ignore_public_acls       = false
  restrict_public_buckets  = false

  force_destroy = true
  policy        = <<-EOT
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["${module.acme-s3.s3_bucket_arn}"]
    }
  ]
  EOT

  website = {
    index_document = "index.html"
  }
}

module "s3-bucket_object" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version = "3.11.0"

  acl          = "public-read"
  content_type = "text/html"
  file_source  = "index.html"
  bucket       = module.acme-s3.s3_bucket_id
  key          = "index.html"
  etag         = filemd5("index.html")
}
