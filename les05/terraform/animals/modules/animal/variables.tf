variable "prefix" {
  type = string
  default = "otus"
}
 
variable "nickname" {
  type = string
  default = "otus"
}

variable "subnet_id" {
  type = string
  default = "e9bop98iu12teftg4uj8"
}

variable "pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}

