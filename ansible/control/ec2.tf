module "ansible-control" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name               = module.key_pair.key_pair_key_name
  vpc_security_group_ids = [module.security-group.security_group_id]
  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = true

  user_data = <<EOF
#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install software-properties-common 
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible
sudo apt-get -y install python3-argcomplete
sudo activate-global-python-argcomplete3
EOF

  tags = {
    Terraform = "true"
    Owner     = "acme demo org"
  }
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "ansible-control"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/rTu3biHujG2wId3Tb9Ze8mR/dBAnQsnDEkeYmr8IvW0RoC8BQRbsp8U/4dQSTsEGS5KIuDR6JJnTziMY60+mlvbCTeY3uXoXrOG9Cm6YT8zrtWauxVF7oZnB5/tWkeKJP2iRJR0DMlYB0QAYH8mwOaL3b9jT0Q1lPQXDf00BWLbMJMlSA+JJR1mRpqWWD3Ba4bju6TeHxrHoyCdVB7/r4pypYuO1ZSZx9zQd07ggdWDVm3YNhqj4hexQMfVnLc5adHLNpT+h30NKdyU+RndavePvrEsofr+6zZBfsXKDCU1LE6kdq++rmHZv7IpEQaEPJ7VoVRBx4l1dnpnwBeyKq0S9SE2i+5NqdAB6pRN0odNtSWt3geovxrEkEW9CPFqDZl1ViM5dDINT9M11dAnGKZ6A28o82c5PQDE8NRwBFpWUwkwkUdypuBX9Wq3AXDGuwCNFy29E5ye6MOx1MSMEbFFIeWxX+8cxMXnQX2ioJ8kjPDAP3Fn0+98StAo+2zM= contact@env0.com"

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