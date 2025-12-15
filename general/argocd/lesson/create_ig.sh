set -x
yc iam service-account create --name $YC_IG

# Роль alb.editor нужна для создания балансировщиков
yc resource-manager folder add-access-binding \
  --id=$YC_FOLDER_ID \
  --service-account-name=$YC_IG \
  --role alb.editor

# Роль vpc.publicAdmin нужна для управления внешними адресами
yc resource-manager folder add-access-binding \
  --id=$YC_FOLDER_ID \
  --service-account-name=$YC_IG \
  --role vpc.publicAdmin

# Роль certificate-manager.certificates.downloader
# нужна для скачивания сертификатов из Yandex Certificate Manager
yc resource-manager folder add-access-binding \
  --id=$YC_FOLDER_ID \
  --service-account-name=$YC_IG \
  --role certificate-manager.certificates.downloader

# Роль compute.viewer нужна для добавления нод в балансировщик
yc resource-manager folder add-access-binding \
  --id=$YC_FOLDER_ID \
  --service-account-name=$YC_IG \
  --role compute.viewer

mkdir -p sensitive
yc iam key create --service-account-name $YC_IG --output sensitive/sa-key.json
set +x