set -x
ansible -c local -i 'localhost,' -a 'ansible --version' all
