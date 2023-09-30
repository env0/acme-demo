variable "environments" {
  type = map(
    object({
      project_name = string
      name        = string
      description = optional(string)
      credential  = optional(string)
    }))
}

variable "github_id" {
  type = string
  default = "11551359"
  description = "fix it to your installation id"
}

variable "repo" {
  type = string 
  default = "https://github.com/env0/acme-demo"
  description = "repo url"
}
