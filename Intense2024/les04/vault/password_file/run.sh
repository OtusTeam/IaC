set -x
rm test.txt
echo "my test password" > ignore/password_file
read -n 1 -s -r -p "press any key to continue..."; echo ""
env EDITOR=nano ansible-vault create --vault-password-file ignore/password_file test.txt
cat test.txt
read -n 1 -s -r -p "press any key to continue..."; echo ""
env EDITOR=nano ansible-vault edit --vault-password-file ignore/password_file test.txt
ansible-vault view --vault-password-file ignore/password_file test.txt
rm test.txt
