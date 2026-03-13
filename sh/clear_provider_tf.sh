set -x
read -p "Press any key to remove the .terraform* directory and files (from the current directory and subdirectories)..." 
rm -rf $(find . -type d -name ".terraform")
rm -rf $(find . -type f -name ".terraform.lock.hcl")
set +x