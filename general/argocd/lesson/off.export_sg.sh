#export YC_SG_ID=$(yc vpc security-group get --name $YC_SG | head -1 | awk '{print $2}')
export YC_SG_ID=$(yc vpc security-group get $YC_SG --jq '.id')
