variable "yc_default_zone" {
  type = string
  description = "Yandex Cloud default zone"
  default = "ru-central1-a"
}

variable "network_id" {
}

variable "subnet_index" {
  type = number
  default = 1
}

variable "kind" {
  description = "kind of animal"
}

