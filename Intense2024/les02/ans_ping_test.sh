set -x
ansible -i "$test_ip", -m ping all
