resource "yandex_serverless_container" "nginx" {
  name               = "nginx"
  memory             = 1024
  service_account_id = var.yc_puller_sa
  image {
      url = var.yc_registry_image_url
  }
}
