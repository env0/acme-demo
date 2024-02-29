output "instances" {
  value = module.acme-ec2.id
}

output "public_ip" {
  value = module.acme-ec2.public_ip
}

# output "vpc_security_group_ids" {
#   value = module.acme-ec2.vpc_security_group_ids
# }