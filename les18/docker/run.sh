set -x
mkdir -p data
rm data/out.txt
cat Vagrantfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant up
read -n 1 -s -r -p "press any key to continue..."; echo ""
ls -la data/out.txt
cat data/out.txt
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant ssh -c 'ls -la /vagrant_data/out.txt; cat /vagrant_data/out.txt; ls /vagrant'
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant destroy
read -n 1 -s -r -p "press any key to continue..."; echo ""
vagrant status
