export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_ZONE=$(yc config get compute-default-zone)
export YC_TOKEN=$(yc iam create-token)

export TF_VAR_yc_token="$YC_TOKEN"
export TF_VAR_yc_cloud="$YC_CLOUD_ID"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_pub_key_path="~/.ssh/id_rsa.pub"
export TF_VAR_sec_key_path="~/.ssh/id_rsa"
export TF_VAR_prefix="les06"

export TF_VAR_pub_key_file="~/.ssh/id_rsa.pub"
export TF_VAR_sec_key_file="$HOME/.ssh/id_rsa"

export TF_VAR_yc_folder="b1gphr6mcggqjvd9kl4h"
export TF_VAR_yc_default_zone="$YC_ZONE"
export TF_VAR_yc_subnet_id="e9bjdd84pueqaq0ki9tf"

dir="/usr/local/go/bin"

# Проверка: путь не пустой и существует как каталог
if [ -z "$dir" ] || [ ! -d "$dir" ]; then
  echo "Ошибка: каталог '$dir' пустой или не существует" >&2
  exit 1
fi

# Добавить в конец PATH только если ещё нет
case ":$PATH:" in
  *":$dir:"*) ;;                # уже есть — ничего не делаем
  *) PATH="$PATH:$dir" ;;       # добавить в конец
esac

export PATH
