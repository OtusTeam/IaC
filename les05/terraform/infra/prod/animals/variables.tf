variable "yc_cloud" {
  type = string
  description = "Yandex Cloud ID"
}

/*
variable "yc_folder" {
  type = string
  description = "Yandex Cloud folder"
}
*/

variable "yc_dev_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_prod_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_sand_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_test_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_token" {
  type = string
  description = "Yandex Cloud OAuth token"
  sensitive = true
}

variable "yc_default_zone" {
  type = string
  description = "Yandex Cloud default zone"
  default = "ru-central1-a"
}


variable "pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}

