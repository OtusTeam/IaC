# находим в облаке образ ОС по имени:
data "yandex_compute_image" "ubuntu_image" {
  family = var.image_name
}

