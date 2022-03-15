output "instances" {
  value = module.acme-ec2.id
}

output "ip_address" {
  value = module.acme-ec2.associate_public_ip_address
}