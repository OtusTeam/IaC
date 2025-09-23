set -x
terraform init
terraform apply
yc compute instance get --full --name refresh-only --format json
read -n 1 -s -r -p "Change VM and press any key to continue..."; echo ""
yc compute instance get --full --name refresh-only --format json
terraform plan -refresh-only
read -n 1 -s -r -p "press any key to continue..."; echo ""
terraform destroy
set +x
