terraform {
  backend "s3" {
    bucket = "acme-demo-tfstate-dev"
    key    = "ec2-import/iota"
    region = "us-west-2"
  }
}
