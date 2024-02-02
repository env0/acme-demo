run "test" {
  variables {
    name = "module-test-ec2"
    instance_count = 1
    instance_type = "t3a.micro"
    tags = {"purpose": "module test"}
  }

  assert {
    condition     = module.acme-ec2.public_ip != ""
    error_message = "Public IP exists"
  }
}