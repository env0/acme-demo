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
java -Xms1G -Xmx1G -jar server.jar --nogui
EOF

  tags = {
    Terraform = "true"
    Owner     = "Andrew Way"
    Demo      = "Minecraft Server"
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



################################################################################
# Supporting Resources
################################################################################


module "minecraft_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SSH & Minecraft"
  description = "SSH & Minecraft"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 25565
      to_port     = 25565
      protocol    = "tcp"
      description = "Minecraft"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
}

// resource "aws_volume_attachment" "this" {
//   device_name = "/dev/sdh"
//   volume_id   = aws_ebs_volume.this.id
//   instance_id = module.ec2.id
// }

resource "aws_ebs_volume" "this" {
  availability_zone = local.availability_zone
  size              = var.ebs_size
}