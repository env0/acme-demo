module "acme-ec2" {
  source  = "../modules/ec2"
  
  name           = var.name
  instance_count = var.instance_count
  instance_type  = var.instance_type
  tags           = var.tags
  ebs_size       = var.ebs_size
  vpc_id         = var.vpc_id
}
