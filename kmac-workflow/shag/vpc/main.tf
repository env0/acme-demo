module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name                 = "vpc-${var.cluster_name}"
  cidr                 = var.cidr
  azs                  = data.aws_ec2_instance_type_offerings.supported_azs.locations
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    "tier"                                      = "private"
  }
}

data "aws_ec2_instance_type_offerings" "supported_azs" {
    filter {
      name   = "instance-type"
      values = [var.instance_type]
    }

    location_type = "availability-zone"
}
