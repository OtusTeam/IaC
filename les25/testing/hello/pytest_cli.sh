set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init test
set -x

pulumi up -y

pytest --verbosity=1 pytest_cli.py

echo

set -x

pulumi destroy -y
pulumi stack rm test -y -f
set +x
