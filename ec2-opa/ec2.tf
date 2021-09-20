module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name
  instance_count = var.instance_count

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = "AWay"
  vpc_security_group_ids = [module.web_server_sg.security_group_id, aws_security_group.allow_ssh.id]
  subnet_ids             = data.aws_subnet_ids.default.ids

  associate_public_ip_address = true

  user_data = <<EOF
#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
sudo echo "Welcome to env0, this is: $PUBLIC_IPV4" > /usr/share/nginx/html/index.html
EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Test        = "sept 20"
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
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "my_security_group"
  description = "Allow SSH Trafic"

  ingress {
    description = "Incoming ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }
}