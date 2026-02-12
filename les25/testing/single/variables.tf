variable "prefix" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_cloud_id" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
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
  default = "ru-central1-a"
}

variable "yc_username" {
   type = string
   default = "ubuntu"
}

variable "pub_key_path" {
  type = string
  sensitive = true
}

