
variable "instance_count" {
  type    = number
  default = 3
}

variable "name_prefix" {
  type    = string
  default = "les01"
}

variable "cores" { default = 2 }
variable "memory" { default = 2 }

variable "image_id" {
  type    = string
  default = "fd89eh9ba36b7cggtan6" # lemp
}

variable "subnet_id" {
  type = string
  description = "ID подсети"
  default = "e9bop98iu12teftg4uj8"
}

variable "pub_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "nlb_name" { default = "les01-nlb" }
variable "listener_port" { default = 80 }
variable "target_port" { default = 80 }
