run "test-variable-inputs" {
  variables {
    name = "module-test-ec2"
    instance_count = 1
    instance_type = "t3a.micro"
    tags = {"purpose": "module test"}
    security_group_ids = null
  }

  assert {
    condition     = module.acme-ec2.public_ip != ""
    error_message = "Public IP exists"
  }

  assert {
    condition     = module.acme-ec2.id != ""
    error_message = "Instance does not have an ID"
  }
}