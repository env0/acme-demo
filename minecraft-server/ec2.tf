module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type


  key_name               = "away"
  vpc_security_group_ids = ["sg-0afe6fd880e15e54e"]
  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = true

  user_data = <<EOF
  #!/bin/bash
  sudo apt-get -y update
  sudo apt-get -y install openjdk-17-jre-headless
  java -Xms1G -Xmx1G -jar server.jar --nogui
  EOF

  tags = {
    Terraform   = "true"
    Owner       = "Andrew Way"
    Demo        = "Minecraft Server"
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = module.acme-ec2.id
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = module.acme-ec2.availability_zone
  size              = var.ebs_size
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
