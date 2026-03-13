set -x
read -p "Press any key to remove the .lake directory (from the current directory and subdirectories)..." 
rm -rf $(find . -type d -name ".lake")
set +x
