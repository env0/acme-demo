output "vault-not-so-secret" {
  value = data.vault_generic_secret.foo
  sensitive = false
}