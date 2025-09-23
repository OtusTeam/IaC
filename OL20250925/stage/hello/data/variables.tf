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

###################################################################################

variable "zone" {
  description = "Зона по умолчанию (можно указывать в data-ресурсах индивидуально)"
  type        = string
  default     = "ru-central1-a"
}

variable "max_instances" {
  description = "Опционально: максимально ожидаемое число инстансов для примера"
  type        = number
  default     = 50
}


