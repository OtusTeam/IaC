variable "yc_cloud" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_folder" {
  type = string
  description = "Yandex Cloud folder"
}

variable "yc_subnet_id" {
  type = string
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

variable "username" {
   type = string
   default = "ubuntu"
}

variable "pub_key_path" {
   type = string
   sensitive = true
   default = "~/.ssh/id_rsa.pub"
}

variable "sec_key_path" {
   type = string
#   sensitive = true
   default = "~/.ssh/id_rsa"
}

variable "image" {
   type = string
   default = "fd883rif8e2s2nqkskao"	# 22.04 LTS Vanilla
}

variable "prefix" {
   type = string
   default = "les10"
}

variable "tfs_vms" {
   type = number
   default = "2"
}
