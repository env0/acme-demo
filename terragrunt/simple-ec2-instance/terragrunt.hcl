remote_state {
  backend = "s3"
  config = {
    bucket         = "acme-demo-tfstate-dev"
    key            = "ec2/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "acme-dev-tfstate-lockdb"
  }
}