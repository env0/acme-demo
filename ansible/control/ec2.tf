module "ansible-control" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name
  instance_count = var.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name               = "AWay"
  vpc_security_group_ids = [module.security-group.security_group_id]
  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = false

  user_data = <<EOF
#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install software-properties-common 
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
EOF

  tags = {
    Terraform = "true"
    Owner     = "acme demo org"
  }
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"
  
  name = "ansible-server"
  description = "SG for Ansible Control, HTTP / SSH"
  vpc_id = data.aws_vpc.selected.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

# data "aws_security_group" "web_server" {
#   name = "webserver"
# }

# resource "aws_volume_attachment" "volume_attachment" {
#   count = var.instance_count

#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.ebs[count.index].id
#   instance_id = module.ansible-control.id[count.index]
# }

# resource "aws_ebs_volume" "ebs" {
#   count = var.instance_count

#   availability_zone = module.ansible-control.availability_zone[count.index]
#   size              = var.ebs_size
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}