resource "yandex_container_registry" "my-reg" {
  name = "my-registry"
  folder_id = var.yc_folder
  labels = {
    my-label = "my-label-value"
  }
}
