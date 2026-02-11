set -x
pulumi convert --from terraform --language python --generate-only
set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
set -x

pulumi up

read -p "Press any key to continue ..."

pulumi destroy
pulumi stack rm dev
set +x
