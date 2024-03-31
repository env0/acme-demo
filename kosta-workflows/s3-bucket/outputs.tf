# output "bucket_name" {
# #   value = "kosta-bucket-${module.random.result}"
#   value = aws_s3_bucket.foo-bucket.bucket
# }

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.kosta-bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.kosta-bucket.arn
}