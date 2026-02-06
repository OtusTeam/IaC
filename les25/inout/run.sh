set -x

echo "ONE" > zero.txt
cat zero.txt

export ONE="Two"

set +x
# Запрос пасфразы (не отображается при вводе)
read -rsp "Enter Pulumi passphrase: " PULUMI_CONFIG_PASSPHRASE
echo
# Экспортировать только для этого скрипта
export PULUMI_CONFIG_PASSPHRASE
pulumi stack init dev
TWO="Three"
pulumi config set inout:Two "$TWO" --secret
echo -n "$TWO" | wc -c
set -x

pulumi config set inout:Three "Four"

pulumi config
pulumi up
pulumi destroy

pulumi stack rm dev
rm zero.txt

set +x
