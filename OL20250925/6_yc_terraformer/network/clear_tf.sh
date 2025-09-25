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

set +x
