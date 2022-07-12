output "instance_id" {
  value = module.ec2.id
}

output "public_ip" {
  value = module.ec2.public_ip
}
