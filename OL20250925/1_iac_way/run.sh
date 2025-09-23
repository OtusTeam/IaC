set -x
terraform init
terraform validate
terraform plan
terraform apply
ls
yc compute instance get --full --name iac-way --format json
read -n 1 -s -r -p "press any key to continue..."; echo ""
terraform destroy
set +x
