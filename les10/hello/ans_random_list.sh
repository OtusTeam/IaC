set -x
ansible-inventory -i random_ip_hello.py --list
ansible-inventory -i random_ip_hello.py --list -y
