module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name
  instance_count = var.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t1000.xxlarge"

  #key_name               = "AWay"
  #vpc_security_group_ids = [data.aws_security_group.web_server.id]
  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = true

  #   user_data = <<EOF
  # #!/bin/bash
  # sudo apt-get -y update
  # sudo apt-get -y install nginx
  # export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
  # sudo echo "Welcome to env0, this is: $PUBLIC_IPV4" > /usr/share/nginx/html/index.html
  # EOF

  tags = {
    Terraform   = "true"
    Owner       = "acme demo org"
    Test        = "add new tag"
  }
}

# data "aws_security_group" "web_server" {
#   name = "webserver"
# }

resource "aws_volume_attachment" "volume_attachment" {
  count = var.instance_count

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs[count.index].id
  instance_id = module.acme-ec2.id[count.index]
}

resource "aws_ebs_volume" "ebs" {
  count = var.instance_count

  availability_zone = module.acme-ec2.availability_zone[count.index]
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