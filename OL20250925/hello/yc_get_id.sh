#set -x
export VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')
