resource "yandex_serverless_container" "hello" {
  name               = "hello"
  memory             = 128
  service_account_id = var.yc_puller_sa
  image {
      url = var.yc_registry_image_url
  }
}
