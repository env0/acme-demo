module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name = "demo-ec2-environment-discovery"

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"

  subnet_ids = data.aws_subnets.selected.ids

  associate_public_ip_address = true

  tags = {
    Terraform = "true"
    Owner     = "acme demo org"
    Test      = "new tag"
    Demo      = "Oct 25"
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

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}
