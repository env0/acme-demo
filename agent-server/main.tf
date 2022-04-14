locals {
  availability_zone = "${local.region}a"
  region            = "us-west-2"
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.5.0"

  name = var.name

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  availability_zone           = local.availability_zone
  subnet_id                   = element(tolist(data.aws_subnet_ids.selected.ids), 0)
  vpc_security_group_ids      = [module.minecraft_sg.security_group_id]
  associate_public_ip_address = true
  key_name                    = "away"

  user_data = <<EOF
#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install openjdk-17-jre-headless
wget https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar
java -Xms1G -Xmx1G -jar server.jar --nogui
EOF

  tags = {
    Terraform = "true"
    Owner     = "Andrew Way"
    Purpose   = "Acme-Fitness Agent Server"
  }
}

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

module "agent_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SSH"
  description = "SSH"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  egress_cidr_blocks = []
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = local.availability_zone
  size              = var.ebs_size
}