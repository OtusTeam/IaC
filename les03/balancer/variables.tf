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

variable "lamp" {
  description = "for lamp webserver"
  default = {
     zone = "ru-central1-a"
     cidr = ["192.168.15.0/24"]
  }
}

variable "lemp" {
  description = "for lamp webserver"
  default = {
     zone = "ru-central1-b"
     cidr = ["192.168.16.0/24"]
  }
}




