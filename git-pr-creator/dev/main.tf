terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
provider "aws" {
  region = "us-west-2"
}

module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name = "Turbo Managed ec2"


  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = false

  tags = {
    Terraform = "true"
    Owner     = "acme demo org"
    Demo      = "Turbo"
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
  id = "vpc-0d806cc612e6cf9e3"
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

variable "instance_type" {
  default = "t3a.micro"
  type    = string
}

output "instance_type" {
  value = var.instance_type
}