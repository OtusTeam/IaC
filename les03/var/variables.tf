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

variable "pub_key_file" {
   type = string
   description = "Public key file path"
   sensitive = true
}

variable "yc_default_zone" {
   type = string
   description = "Yandex Cloud default zone"
}

variable "yc_subnet_id" {
   type = string
   description = "Yandex Cloud subnet id"
}




