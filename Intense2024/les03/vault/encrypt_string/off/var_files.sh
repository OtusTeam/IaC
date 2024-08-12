set -x
echo "secret_username: $(ansible-vault encrypt_string --vault-password-file ignore/password_file admin)" > secrets.yml 
echo "secret_password: $(ansible-vault encrypt_string --vault-password-file ignore/password_file very_secure_password)" >> secrets.yml
cat secrets.yml
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-playbook vault_demo.yml --vault-password-file ignore/password_file

