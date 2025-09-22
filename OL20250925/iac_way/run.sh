set -x
terraform init
terraform validate
terraform plan
terraform apply
ls
yc compute instance get --full --name test --format json
terraform destroy
set +x
