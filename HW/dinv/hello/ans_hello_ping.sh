set -x
ansible -i hello.py -m ping hello
ansible -i hello.py -m ping world
ansible -i hello.py -m ping all

