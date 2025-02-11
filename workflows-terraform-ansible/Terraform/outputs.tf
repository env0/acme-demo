output "url" {
  value = "http://${aws_eip.env0.public_dns}"
}

output "public_ip" {
  value = aws_eip.env0.public_ip
}

output "private_key" {
  value     = tls_private_key.env0.private_key_pem
  sensitive = true
}
