set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
set -x

pytest --verbosity=1 test_api.py

set +x
