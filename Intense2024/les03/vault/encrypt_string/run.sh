set -x
echo "ansible_host: 127.0.0.1" 	> host_vars/myhost.yml
echo "ansible_user: $(ansible-vault encrypt_string --vault-password-file ignore/password_file admin)" 				>> host_vars/myhost.yml
echo "ansible_password: $(ansible-vault encrypt_string --vault-password-file ignore/password_file very_secure_password)"	>> host_vars/myhost.yml
cat host_vars/myhost.yml
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-playbook -i myhost.yml host_vars_print.yml --vault-password-file ignore/password_file

