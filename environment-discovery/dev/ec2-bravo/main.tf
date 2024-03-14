module "acme-ec2" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/ec2-instance/env0"
  version = "~> 1.1.0"

  name           = "ec2-bravo"
  instance_type  = "t3a.nano"
  vpc_id = var.vpc_id
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "env0 Acme Demo"
  }
}