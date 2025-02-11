terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "env0" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "Dev"
  }
}

resource "aws_subnet" "env0" {
  vpc_id     = aws_vpc.env0.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "env0" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.env0.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "env0" {
  vpc_id = aws_vpc.env0.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "env0" {
  vpc_id = aws_vpc.env0.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.env0.id
  }
}

resource "aws_route_table_association" "env0" {
  subnet_id      = aws_subnet.env0.id
  route_table_id = aws_route_table.env0.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_eip" "env0" {
  instance = aws_instance.env0.id
  vpc      = true
}

resource "aws_eip_association" "env0" {
  instance_id   = aws_instance.env0.id
  allocation_id = aws_eip.env0.id
}

resource "aws_instance" "env0" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.env0.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.env0.id
  vpc_security_group_ids      = [aws_security_group.env0.id]

  tags = {
    Name = "${var.prefix}-env0-Jenkins-instance"
  }
}

resource "tls_private_key" "env0" {
  rsa_bits  = 4096
  algorithm = "RSA"
}

resource "aws_key_pair" "env0" {
  key_name   = var.my_aws_key
  public_key = tls_private_key.env0.public_key_openssh
}
