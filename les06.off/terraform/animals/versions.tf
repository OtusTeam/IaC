provider "yandex" {
  zone      = var.yc_default_zone
  folder_id = var.yc_folder
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "> 0.8"
    }
  }
  required_version = ">= 0.13"
}
