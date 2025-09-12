#!/bin/bash

export VM_NAME="hello"

export VM_ID=$(yc compute instance get --name $VM_NAME --format json | jq -r '.id')

set | grep VM_
