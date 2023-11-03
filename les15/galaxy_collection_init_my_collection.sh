cd collections/ansible_collections/
ansible-galaxy collection init my.my_collection
cd -
pwd
cp -r my/roles/ansible_authorized_key collections/ansible_collections/my/my_collection/roles/
mkdir collections/ansible_collections/my/my_collection/plugins/inventory
cp my/my_collection/plugins/inventory/yacloud_compute.py collections/ansible_collections/my/my_collection/plugins/inventory/
cp my/my_collection/ansible.cfg ./
cp -r my/my_collection/inventory ./ 