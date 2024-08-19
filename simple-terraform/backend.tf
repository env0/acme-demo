terraform {
  backend "s3" {
    bucket = "acme-demo-tfstate-dev"
    key    = "migration-test"
    region = "us-west-2"
  }
}