output "instances" {
  value = module.acme-ec2.id
}

output "public_ip" {
  value = module.acme-ec2.public_ip
}

output "private_ip" {
  value = module.acme-ec2.private_ip
}