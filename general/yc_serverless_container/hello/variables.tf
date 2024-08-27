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

variable "yc_subnet_id" {
   type = string
   default = "e9bop98iu12teftg4uj8" # default-ru-central1-a
}

variable "yc_puller_sa" {
   type = string
   default = "ajeps61531r8losd5k2d" # otus puller sa
}

variable "yc_registry_image_url" {
   type = string
   default = "cr.yandex/crpgqba9ldgbfg8ad8j0/hello:latest"
}

