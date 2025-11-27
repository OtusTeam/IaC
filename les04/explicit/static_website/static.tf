variable "yc_otus_folder" {
  default = "b1gmesrdjgklgkvcp704" # otus folder id
}

locals {
  folder_id = var.yc_otus_folder
  domain    = "${local.folder_id}"
  prefix    = "les04-static"
  sa_name   = "${local.prefix}-sa"
  bucket    = "${local.prefix}-web"
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = local.folder_id
}

resource "yandex_iam_service_account" "sa" {
  name      = local.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "default_access" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.bucket
  max_size   = 1073741824  
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "yandex_storage_bucket_iam_binding" "storage_admin" {
  bucket = local.bucket
  role   = "storage.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
  depends_on = [yandex_storage_bucket.default_access]
}

resource "yandex_storage_bucket_grant" "public_read" {
  bucket = local.bucket
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl        = "public-read"
  depends_on = [yandex_storage_bucket_iam_binding.storage_admin]
}

resource "yandex_storage_object" "index-html" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.default_access.id
  key        = "index.html"
  source     = "index.html"
}

resource "yandex_storage_object" "error-html" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.default_access.id
  key        = "error.html"
  source     = "error.html"
}

resource "null_resource" "curl" {
  provisioner "local-exec" {
    command = "curl https://storage.yandexcloud.net/${local.bucket}/index.html"
  }
  provisioner "local-exec" {
    command = "curl https://website.yandexcloud.net/${local.bucket}/"
  }
  depends_on = [yandex_storage_bucket_grant.public_read]
}

output "website_endpoint" {
  value = yandex_storage_bucket.default_access.website_endpoint
}
