set -x
read -p "Press any key to remove the .venv directory (from the current directory and subdirectories)..." 
rm -rf $(find . -type d -name ".venv")
set +x