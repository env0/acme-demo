output "instances" {
  value = module.ansible-managed.id[0]
}

output "ipaddress" {
  value = module.ansible-managed.public_ip[0]
}