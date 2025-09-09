#!/bin/bash

yc compute instance get --name $VM_NAME --format json > vm.json
