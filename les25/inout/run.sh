set -x

echo "ONE" > zero.txt
cat zero.txt

export ONE="Two"

pulumi stack init dev

pulumi config set inout:Two "Three"
set +x
FOUR="My Secret Four"
pulumi config set inout:Three "$FOUR" --secret
echo -n "$FOUR" | wc -c
set -x

pulumi config
pulumi up
pulumi destroy

pulumi stack rm dev
rm zero.txt

set +x
