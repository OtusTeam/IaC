cd collections/ansible_collections/
ansible-galaxy collection init my.my_collection
cd -
pwd
cp -r roles/ansible_authorized_key collections/ansible_collections/my/my_collection/roles/ 
mkdir collections/ansible_collections/my/my_collection/plugins/inventory
cp plugins/inventory/yacloud_compute.py collections/ansible_collections/my/my_collection/plugins/inventory/
