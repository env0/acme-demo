variable "env0_api_key" {
  value        = ""
  is_read_only = true
  is_sensitive = false
}

variable "env0_api_secret" {
  value        = ""
  is_read_only = true
  is_sensitive = true

}

variable "github_installation_id" {
  value        = ""
  is_read_only = true
  is_sensitive = true
}