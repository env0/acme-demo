resource "aws_s3_bucket" "s3" {
  bucket = var.name
  acl    = "private"
}

resource "aws_dynamodb_table" "dynamodb" {
  name           = "${var.name}-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}