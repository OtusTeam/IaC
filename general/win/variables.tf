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
  default = "ru-central1-a"
}

variable "yc_image_id" {
  type = string
  default = "fd890bh2sapn6ofo5p0c"
}

variable "yc_subnet_id" {
  type = string
  description = "Yandec Cloud default subnet"
#  default = "e9bop98iu12teftg4uj8"
}

variable "username" {
   type = string
   default = "ubuntu"
}

variable "pub_key_path" {
   type = string
#   sensitive = true
   default = "~/.ssh/id_rsa.pub"
}

variable "sec_key_path" {
   type = string
   sensitive = true
   default = "~/.ssh/id_rsa"
}
