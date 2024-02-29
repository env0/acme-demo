# module "acme-ec2" {
#   source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/ec2-instance/env0"
#   version = "~> 1.0.1"

#   name           = "ec2-checkov-demo-instance"

#   associate_public_ip_address = true

#   user_data = <<EOF
# #!/bin/bash
# sudo apt-get -y update
# sudo apt-get -y install nginx
# export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
# sudo echo "Welcome to env0, this is: $PUBLIC_IPV4" > /usr/share/nginx/html/index.html
# EOF

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#     Owner       = "env0 Acme Demo"
#   }
# }

module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-server"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = [var.ssh_cidr_block]
}