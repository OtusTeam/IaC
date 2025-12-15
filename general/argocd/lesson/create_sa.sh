set -x
# Создайте аккаунт
yc iam service-account create $YC_SA

# Назначьте сервисному аккаунту роль editor и выше
# От его имени будут создаваться ресурсы, необходимые кластеру Kubernetes
yc resource-manager folder add-access-binding \
  --id=$YC_FOLDER_ID \
  --service-account-name=$YC_SA \
  --role=editor
set +x