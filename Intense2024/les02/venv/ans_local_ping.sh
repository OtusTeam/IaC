set -x
ansible -c local -i 'localhost,' -m ping all
