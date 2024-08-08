set -x
ansible-playbook -i "$test_ip", force_handlers.yaml
