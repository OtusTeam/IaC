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

set +x

