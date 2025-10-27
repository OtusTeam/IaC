variable "instance_count" {
  type        = number
  default     = 2
  description = "Количество инстансов"
}

variable "name_prefix" {
  type        = string
  default     = "les01-auto-lemp"
  description = "Префикс имени инстанса; к нему добавится индекс"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2
}

variable "image_id" {
  type    = string
  default = "fd89eh9ba36b7cggtan6"
}

variable "subnet_id" {
  type    = string
  default = "e9bop98iu12teftg4uj8"
}

variable "ssh_pubkey_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}
