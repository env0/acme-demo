variable "root_folder" {
  type        = string
  description = "The folder to check for any changes"
}

variable "repository" {
  type        = string
  description = "repo setting for all environments"
}


// example input
// {dev0={name=\"dev\",description=\"this is my dev project\",credential=\"aws dev\"}}
variable "environments" {
  type = map(
    object({
      project_id  = string
      path        = string
      //force_destroy = bool
    })
  )
}