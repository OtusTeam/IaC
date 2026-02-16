set -x
terraform apply # -auto-approve 
export VM_PUBLIC_IP="$(terraform output -raw vm_public_ip)"
ping "$VM_PUBLIC_IP"
ssh.sh "$YC_USERNAME"@"$VM_PUBLIC_IP" ping -c 1 otus.ru  
read -p "press any key to continue ..."
terraform destroy # -auto-approve 
set +x
