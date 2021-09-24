output "instances" {
  value = module.ansible-control.id
}

output "ipaddress" {
  value = module.ansible-control.public_ip
}