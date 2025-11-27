set -x

terraform apply

curl https://$(terraform output -raw website_endpoint)

terraform destroy

yc storage buckets delete les04-static-web --folder-id $YC_OTUS_FOLDER_ID
yc iam service-account delete les04-static-sa --folder-id $YC_OTUS_FOLDER_ID

echo 'If not deleted use the web console to delete bucket "les04-static-sa" and sa "les04-static-sa"!'
read -p "Press any key to clear current terraform.tfstate"

# save and clear current state: 
cp terraform.tfstate terraform.tfstate.$(date +%s)
cp tfs.empty terraform.tfstate

set +x

