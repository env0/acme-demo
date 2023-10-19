output "url" {
  value = "http://${module.acme-s3.s3_bucket_website_endpoint}"
}

output "bucketname" {
  value = "${var.bucketname}-${random_string.random.id}"
}