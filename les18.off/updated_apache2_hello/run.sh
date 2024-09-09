set -x
cat Vagrantfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant up
read -n 1 -s -r -p "press any key to continue..."; echo ""
curl http://127.0.0.1:8080
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant destroy
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant status
