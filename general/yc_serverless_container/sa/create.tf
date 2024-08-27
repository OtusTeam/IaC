resource "yandex_iam_service_account" "images_puller" {
  name        = "images-puller"
  description = "pull images from registry"
}

resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
  folder_id   = var.yc_folder
  role        = "container-registry.images.puller"
  member      = "serviceAccount:${yandex_iam_service_account.images_puller.id}"
}
