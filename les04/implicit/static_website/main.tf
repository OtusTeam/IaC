# сервисный эккаунт, от имени которого будем манипулировать бакетом s3: 
resource "yandex_iam_service_account" "sa" {
  name      = local.sa_name
}

# назначаем роль редактора для сервисного эккаунта:
resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# генерируем статические ключи для доступа к бакету s3:
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

# создаем бакет s3 под размещение страниц статического вебсайта:
resource "yandex_storage_bucket" "website" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket     = local.bucket
  max_size   = 1073741824  
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# назначаем сервисный эккаунт администратором бакета s3:
resource "yandex_storage_bucket_iam_binding" "storage_admin" {
  bucket = local.bucket
  role   = "storage.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}

# от имени сервисного эккаунта разрешаем публичный доступ на чтение к бакету s3
resource "yandex_storage_bucket_grant" "public_read" {
  bucket = local.bucket
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  acl        = "public-read"
}

# загружаем стартовую web-страницу в бакет s3:
resource "yandex_storage_object" "index-html" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket     = yandex_storage_bucket.website.id
  key        = "index.html"
  source     = "index.html"
}

# загружаем web-страницу с сообщением об ошибке в бакет s3:
resource "yandex_storage_object" "error-html" {
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket     = yandex_storage_bucket.website.id
  key        = "error.html"
  source     = "error.html"
}

# проверяем размещение стартовой web-страницы в публичном доступе:
resource "null_resource" "curl" {
  # как файла в бакете s3:
  provisioner "local-exec" {
    command = "curl https://storage.yandexcloud.net/${local.bucket}/index.html"
  }
  # как стартовой web-страницы статического web-сайта:
  provisioner "local-exec" {
    command = "curl https://website.yandexcloud.net/${local.bucket}/"
  }
}
