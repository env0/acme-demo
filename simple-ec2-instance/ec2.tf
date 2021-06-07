

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = variable.name
  instance_count         = variable.instance_count

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = variable.instance_type
  key_name               = "AWay"
  vpc_security_group_ids = [module.web_server_sg.security_group_id]

  associate_public_ip_address = true

  user_data =<<EOF
  #!/bin/bash
  apt-get -y update
  apt-get -y install nginx
  export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
  echo "Welcome to env0, this is: $PUBLIC_IPV4" > /usr/share/nginx/html/index.html
  EOF
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_vpc" "default" {
  default = true
}