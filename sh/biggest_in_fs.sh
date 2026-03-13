echo "Find biggest directories or files in current filesystem (from the current directory and subdirectories)..." 
export LARGER_THAN="99999999"
export IN_THE_AMOUNT_OF="20"
set -x
sudo du -x -h -t $LARGER_THAN | sort -hr | head -n $IN_THE_AMOUNT_OF
set +x