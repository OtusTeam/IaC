
variable "nickname" {
  type = string
  default = "Hey"
}

variable "subnet_id" {
  type = string
}

variable "pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}

