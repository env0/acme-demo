run "vpc-tests" {
  variables {
    name = "module-test-ec2"
    region = "us-east-2"
  }

  assert {
    condition     = module.vpc.name == "module-test-ec2"
    error_message = "VPC Name did not match"
  }

  assert {
    condition     = count(module.vpc.azs) >= 2
    error_message = "Number of AZs need to be >= 2"
  }
}