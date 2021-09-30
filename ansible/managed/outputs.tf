output "instances" {
  value = module.ansible-control.id[0]
}

output "ipaddress" {
  value = module.ansible-control.public_ip[0]
}