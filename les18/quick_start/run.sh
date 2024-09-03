set -x
rm Vagrantfile
vagrant init https://mirror.yandex.ru/ubuntu-cloud-images/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
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
