
# source from https://github.com/awh0ll/ansible-inventory-population/blob/master/main.py
# changed by Aleksei E. Zhuravlev for accepting YC-provider stucture of tfstate-file

import json

class Host:
    def __init__(self, hostName, nat_ip=None, ssh_user=None, keyPath = None):
        self.name = hostName
        self.nat_ip = nat_ip
        self.ssh_user = ssh_user
        self.key = keyPath

#Take in a list of hosts, output it to a file name "hosts" in the execution directory.
def output_hosts(hostList):
    hostFile = open("hosts", "w")

    for i in hostList:
        temp = [i.name]
        if i.nat_ip is not None:
            temp.append(" ansible_host=" + i.nat_ip)
        if i.ssh_user is not None:
            temp.append(" ansible_user=" + i.ssh_user)
        if i.key is not None:
            temp.append(" ansible_ssh_private_key_file=" + i.key)

        hostFile.write(" ".join(temp) + "\n")

    hostFile.close()

stateFile = open('terraform.tfstate')
data = json.load(stateFile)

#ansible hosts
hosts = []

#Iterate through the resources in tfstate
for i in data['resources']:
    #We only care about AWS instances
    if i['type'] == "yandex_compute_instance":
        for j in i['instances']:
            hosts.append(Host(j['attributes']['name'], j['attributes']['network_interface'][0]['nat_ip_address'], j['attributes']['metadata']['ssh-keys'].split(':')[0]))


output_hosts(hosts)
#print(hosts[0].name)
#print(hosts[0].nat_ip)
#print(hosts[0].ssh_user)

stateFile.close()
