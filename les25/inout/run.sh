set -x

echo "One is 1" > input.txt
export MY_VAR="Two is 2"

pulumi stack init dev

pulumi config set inout:three "Three is 3"
set +x
MY_SECRET="Four is 4"
pulumi config set inout:four "$MY_SECRET" --secret
set -x

cat input.txt
echo -n "$MY_SECRET" | wc -c
pulumi config
pulumi up
pulumi destroy

pulumi stack rm dev
rm input.txt

set +x
