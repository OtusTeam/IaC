resource "yandex_iam_service_account" "sa4org" {
  name        = "sa4org"
  description = "admin service accunt"
  folder_id   = var.yc_folder
}

/*
resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
  folder_id   = var.yc_folder 
  role        = "admin"
  member      = "serviceAccount:${yandex_iam_service_account.sa4org.id}"
}
*/

resource "yandex_organizationmanager_organization_iam_binding" "editor" {
  organization_id   = var.yc_organization
  role              = "organization-manager.admin"
  members           = [
                        "serviceAccount:${yandex_iam_service_account.sa4org.id}"
                      ]
}

resource "null_resource" "list_organization_sa" {

  provisioner "local-exec" {
     command = "yc organization-manager organization list-access-bindings ${var.yc_organization}"
  }

  depends_on = [yandex_organizationmanager_organization_iam_binding.editor]
}
