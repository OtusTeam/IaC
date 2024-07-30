set -x
ansible -i random_ip_hello.py -m ping hello
