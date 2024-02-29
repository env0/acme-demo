module "acme-ec2" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/ec2-instance/env0"
  version = "~> 1.0.0"

  name           = "ec2-checkov-demo-instance"
  instance_type  = "t3a.nano"
  vpc_id = var.vpc_id

  security_group_ids = [module.ssh_sg.id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "env0 Acme Demo"
  }
}

module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-server"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = [var.ssh_cidr_block]
}