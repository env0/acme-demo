module "acme-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.name

  ami           = "ami-03f9c150b539fa2d1-XXX"
  instance_type = "t3a.large"

  subnet_ids = data.aws_subnet_ids.selected.ids

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Owner       = "acme demo org"
    Test        = "new tag"
    Demo        = "Aug 11"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}
