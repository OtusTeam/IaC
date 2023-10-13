import json

class Host:
    def __init__(self, hostName, nat_ip=None, ssh_user=None, certPath = None):
        self.name = hostName
        self.cert = certPath

#Take in a list of hosts, output it to a file name "hosts" in the execution directory.
def output_hosts(hostList):
    hostFile = open("hosts", "w")

    for i in hostList:
        temp = [i.name]
        if i.nat_ip is not None:
            temp.append(" ansible_host=" + i.nat_ip)
        if i.ssh_user is not None:
            temp.append(" ansible_name=" + i.ssh_user)
        if i.cert is not None:
            temp.append(" ansible_ssh_private_key_file=" + i.cert)

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
            hosts.append(Host(j['attributes']['name'], j['attributes']['network_interface'][0]['nat_ip_address']))

output_hosts(hosts)
print(hosts[0].name)
print(hosts[0].nat_ip)

stateFile.close()
