set -x
ansible-playbook -i "$test_ip", -t version install_ansible.yaml

