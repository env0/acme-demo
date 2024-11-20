terraform {
  backend "s3" {
    bucket = "acme-demo-tfstate-dev"
    key    = "ec2-import/omega"
    region = "us-west-2"
  }
}
