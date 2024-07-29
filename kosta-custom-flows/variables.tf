variable "ssh_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "vpc_id" {
  type = string
}

# Example of a List
variable "menu_item" {
  type        = list(string)
  description = "A list of the items to order from the menu"
  default     = ["philly", "medium", "thin"]
}

# Example of a Map
variable "credit_card" {
  type        = map(string)
  description = "Credit Card Info"
  sensitive   = true
  default     = {
    number      = 123456789101112
    cvv         = 1314
    date        = "15/16"
    postal_code = "18192"
  }
}
