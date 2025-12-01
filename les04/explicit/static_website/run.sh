set -x

terraform validate
read -p "Press enter to continue..."
terraform graph > graph.txt
cat graph.txt
read -p "Press enter to continue..."
cat graph.txt | dot -Tsvg > graph.svg
read -p "Press enter to continue..."
xdg-open graph.svg
read -p "Press enter to continue..."


terraform apply
curl https://$(terraform output -raw website_endpoint)
read -p "Press enter to destroy infra..."
terraform destroy

yc storage buckets delete les04-explicit-static-web --folder-id $YC_OTUS_FOLDER_ID
yc iam service-account delete les04-explicit-static-sa --folder-id $YC_OTUS_FOLDER_ID

echo 'If not deleted use the web console to delete bucket "les04-static-sa" and sa "les04-static-sa"!'
read -p "Press enter to continue to clear current terraform.tfstate..."

# save and clear current state:
cp terraform.tfstate terraform.tfstate.$(date +%s)
cp tfs.empty terraform.tfstate

set +x

