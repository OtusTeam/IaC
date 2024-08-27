resource "yandex_serverless_container" "hello" {
  name               = "hello"
  memory             = 128
  service_account_id = "<идентификатор_сервисного_аккаунта>"
  image {
      url = "cr.yandex/crpgqba9ldgbfg8ad8j0/hello:latest"
  }
}
