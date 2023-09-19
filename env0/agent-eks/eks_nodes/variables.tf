variable "region" {
  type    = string
  default = "us-west-2"
}

variable "cluster_name" {
  type    = string
  default = "acme"
}

variable "min_capacity" {
  description = "Min number of workers"
  default     = 1
}

variable "instance_type" {
  type    = string
  default = "t4g.large"
}