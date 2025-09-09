#!/bin/bash

set -x

yc compute instance delete --name $VM_NAME
