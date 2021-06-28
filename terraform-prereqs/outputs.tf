output "bucketname" {
  value = aws_s3_bucket.s3.bucket
}

output "dynamodb_name" {
  value = aws_dynamodb_table.dynamodb.name
}