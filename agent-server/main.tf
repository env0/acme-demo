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
  subnet_id                   = element(tolist(data.aws_subnets.selected.ids), 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true
  key_name                    = "away"
  iam_instance_profile        = "Acme-Fitness-EC2-Agent"
  root_block_device = [
    {
      encrypted   = true
      volume_size = var.ebs_size
    },
  ]

  user_data = <<EOF
#!/bin/bash
sudo apt-get -y update
sudo apt-get install jq awscli -y
# k3s only
# curl https://kurl.sh/dbf7043 | sudo bash
# get installscript
INSTALL=/opt/env0
HOME=/home/ubuntu
mkdir -p $INSTALL/scripts

#Copy API KEY from SecretsManager
APIKEY=$(aws secretsmanager get-secret-value --region us-west-2 --secret-id acme-fitness/env0/apikey | jq -r '.SecretString' | jq -r '.ENV0_API_KEY')
APISECRET=$(aws secretsmanager get-secret-value --region us-west-2 --secret-id acme-fitness/env0/apikey | jq -r '.SecretString' | jq -r '.ENV0_API_SECRET')
mkdir -p $INSTALL/scripts
echo "ENV0_API_KEY=$APIKEY" > $INSTALL/scripts/setup.sh
echo "ENV0_API_SECRET=$APISECRET" >> $INSTALL/scripts/setup.sh
echo "ENV0_ORGANIZATION_ID=${var.ENV0_ORGANIZATION_ID}" >> $INSTALL/scripts/setup.sh
echo "INSTALL=$INSTALL" >> $INSTALL/scripts/setup.sh
echo "HOME=$HOME" >> $INSTALL/scripts/setup.sh

#Download main installer
curl -sfL -o $INSTALL/scripts/prereq.sh https://raw.githubusercontent.com/env0/acme-demo/main/agent-server/scripts/prereq.sh
sudo chmod 750 $INSTALL/scripts/prereq.sh
cd $INSTALL
$INSTALL/scripts/prereq.sh
$INSTALL/scripts/agentInstall.sh
sudo chown -R ubuntu $INSTALL
sudo chgrp -R ubuntu $INSTALL
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

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "availability-zone"
    values = [local.availability_zone]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SSH"
  description = "SSH"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 30880
      to_port     = 30880
      protocol    = "tcp"
      description = "KOTS"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      description = "K8s"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "All Outbound"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

// resource "aws_volume_attachment" "this" {
//   device_name = "/dev/sdh"
//   volume_id   = aws_ebs_volume.this.id
//   instance_id = module.ec2.id
// }

// resource "aws_ebs_volume" "this" {
//   availability_zone = local.availability_zone
//   size              = var.ebs_size
// }
