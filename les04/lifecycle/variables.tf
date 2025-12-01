variable "yc_cloud" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_token" {
  type = string
  description = "Yandex Cloud OAuth token"
}

variable "yc_default_zone" {
   type = string
   description = "Yandex Cloud default zone"
}

variable "yc_subnet_id" {
   type = string
   description = "Yandex Cloud subnet id"
}

variable "image_name" {
  type = string
  default = "ubuntu-2204-lts"
  description = "Yandex Image Name"
}

variable "prefix" {
   type = string
   default = "les04"
}
