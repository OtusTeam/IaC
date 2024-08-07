set -x
ansible-playbook -i 'localhost,' -c local -e location=outside hello_from.yml
