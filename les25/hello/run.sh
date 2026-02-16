set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
set -x

pulumi up #-y
pulumi stack output
pulumi destroy #-y
pulumi stack rm dev #-y -f

set +x
