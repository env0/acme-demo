output "instances" {
  value = module.acme-ec2.id
}

output "public_ip" {
  value = module.acme-ec2.public_ip
}