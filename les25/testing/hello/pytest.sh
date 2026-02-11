set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init test
set -x

pulumi up --yes

pytest --verbosity=1 test.py

echo

set -x

pulumi destroy --yes
pulumi stack rm test -y
set +x
