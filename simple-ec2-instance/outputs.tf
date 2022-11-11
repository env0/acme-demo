output "instance" {
  value = module.acme-ec2-1.id
}

output "ip" {
  value = module.acme-ec2-1.public_ip
}

