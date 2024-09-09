set -x
rm Vagrantfile
vagrant init -m ubuntu/jammy64 http://vagrant.elab.pro:80/ubuntu/22.04/1.0.0/virtualbox
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
