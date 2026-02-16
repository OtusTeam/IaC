set -x
pulumi convert --from terraform --language python --generate-only
set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init test		
set -x

pulumi up -y

read -p "Press any key to continue ..."

pulumi destroy -y
pulumi stack rm test -y -f
set +x
