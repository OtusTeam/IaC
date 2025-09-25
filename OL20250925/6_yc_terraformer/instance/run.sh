set -x

read -p "ВНИМАНИЕ!!! Относящиеся к Terraform файлы и каталог будет стерты (Terraform's files and dir will be erased)! Продолжить (Continue)? (Y/[n]) " -n 1 -r
if [[ $REPLY =~ ^[Y]$ ]]; then
  echo "Продолжаем выполнение скрипта (script will run!)"
else
  echo "Выходим из скрипта (script is canceled)"
  exit 1
fi

rm -r .terraform
rm .terraform.lock.hcl
rm .terraform.tfstate.lock.info
rm terraform.tfstate
rm terraform.tfstate.*
rm *.tf
rm *.tfvars

cp -r init/.* ./
cp -r init/* ./

VM_NAME="hello"
VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')

./yc-terraformer.py --import-metadata --with-state compute instance $VM_NAME $VM_ID
cat yandex_compute_instance_hello_fhm2lcv4n95lnl5ka1da.tf

cp vars_4_instance/* ./

terraform plan

set +x
