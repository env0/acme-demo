# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "kosta-bucket-clickops"
resource "aws_s3_bucket" "s3_bucket_demo" {
  bucket              = "kosta-bucket-iac"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
