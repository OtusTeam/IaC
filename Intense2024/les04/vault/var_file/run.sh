set -x
cp origin.yml secrets.yml
cat secrets.yml
read -n 1 -s -r -p "press any key to continue..."; echo ""
chmod 664 secrets.yml
ansible-vault encrypt secrets.yml
cat secrets.yml
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-playbook vault_demo.yml --ask-vault-pass
rm secrets.yml
