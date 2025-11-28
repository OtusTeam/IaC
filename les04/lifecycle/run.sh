set -x
terraform apply
read -p "Press enter to continue ..."
terraform apply -var image_name="ubuntu-2404-lts"
read -p "Press enter to continue ..."
terraform destroy
set +x
