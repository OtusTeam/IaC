set -x
rm Vagrantfile
set | grep VAGRANT
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant init -m ubuntu/jammy64
read -n 1 -s -r -p "press any key to continue..."; echo ""
cat Vagrantfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant up
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant status
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant ssh
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant destroy
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant status
