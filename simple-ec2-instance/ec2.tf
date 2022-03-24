module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type


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
    Test        = "new tag"
    Demo        = "March 15 12:34PM PT"
  }
}

# data "aws_security_group" "web_server" {
#   name = "webserver"
# }

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
