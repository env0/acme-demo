path "auth/token/create" {
  capabilities = ["update"]
}

path "secret/data/*" {
  capabilities = ["create", "update", "read"]
}
