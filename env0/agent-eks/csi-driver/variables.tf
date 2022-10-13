variable "cluster_name" {
  type = string
}

variable "reclaim_policy" {
  type    = string
  default = "Retain"
}
