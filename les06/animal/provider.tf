provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud
  folder_id = var.yc_folder
  zone      = var.yc_default_zone
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
