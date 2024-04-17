ansible -i inv -a 'systemctl status wazuh-indexer' mw
ansible -i inv -a 'systemctl status wazuh-dashboard' mw
ansible -i inv -a 'systemctl status wazuh-manager' mw
ansible -i inv -a 'systemctl status filebeat' mw
ansible -i inv -a 'ss -tulpan' mw



