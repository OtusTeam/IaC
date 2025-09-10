set -x

rm -r .terraform
rm .terraform.lock.hcl
rm terraform.tfstate
rm terraform.tfstate.*
rm *.tf

set +x