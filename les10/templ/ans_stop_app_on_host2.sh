set -x
ansible-playbook -e "target_host='*host2'" stop_app_on_host.yaml
