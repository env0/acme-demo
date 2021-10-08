plugin "aws" {
    enabled = true
    version = "0.7.2"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
  module = true
}