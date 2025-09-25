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

./yc-terraformer.py --import-ids --with-state --recursive vpc network default enpjr0b65u0olvuotmdf
cat yandex_vpc_network_default_enpjr0b65u0olvuotmdf.tf
cat yandex_vpc_subnet_default-ru-central1-c_enpjr0b65u0olvuotmdf.tf

terraform plan

set +x
