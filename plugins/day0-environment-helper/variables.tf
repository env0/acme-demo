# variable "root_folder" {
#   type        = string
#   description = "The folder to check for any changes"
# }

variable "repository" {
  type        = string
  description = "repo setting for all environments"
  default     = "https://github.com/env0/acme-demo"
}


// example input
// {dev0={name=\"dev\",description=\"this is my dev project\",credential=\"aws dev\"}}
variable "environments" {
  type = map(
    object({
      project_id = string
      path       = string
      revision   = string
      //force_destroy = bool
    })
  )

  default = {}
}