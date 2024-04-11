ansible -i inv -a 'systemctl status wazuh-indexer' wazuh
ansible -i inv -a 'systemctl status wazuh-dashboard' wazuh
ansible -i inv -a 'systemctl status wazuh-manager' wazuh
ansible -i inv -a 'systemctl status filebeat' wazuh
ansible -i inv -a 'ss -tulpan' wazuh



