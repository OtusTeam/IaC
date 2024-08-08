set -x
ansible-playbook -i "$test_ip", skip_handlers.yaml
