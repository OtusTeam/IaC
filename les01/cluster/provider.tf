provider "yandex" {
  cloud_id  = "b1glq0cg9jigrj5lcp63"
  folder_id = "b1gmesrdjgklgkvcp704"
  zone      = "ru-central1-a"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
