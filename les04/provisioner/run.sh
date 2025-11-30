set -x
terraform apply
read -p "Press enter to continue ..."
terraform destroy
set +x
