variable "yc_cloud_id" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type = string
  description = "Yandex Cloud folder"
}

variable "prefix" {
  type = string
}

variable "yc_token" {
  type = string
  description = "Yandex Cloud OAuth token"
}

variable "yc_default_zone" {
  type = string
  description = "Yandex Cloud default zone"
  default = "ru-central1-b"
}

variable "yc_subnet_id" {
  type = string
  default = "e2l0ngd4doggtiuk1cbu"	# "default-ru-central1-b"
}

variable "yc_username" {
  type = string
  default = "core"			# Fedora CoreOS 35}
}

variable "yc_image_id" {
  type = string
  default = "fd865udut6b1gvgh5igh"	# Fedora CoreOS 35
}

variable "pub_key_path" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}
