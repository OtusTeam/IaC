output "image_id" {
  description = "Current Image ID"
  value = data.yandex_compute_image.ubuntu_image.id
}
