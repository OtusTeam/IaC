set -x
#curl https://$(jq -r '.resources[4].instances[0].attributes.website_endpoint' terraform.tfstate)
curl https://$(terraform output -raw website_endpoint)
set +x
