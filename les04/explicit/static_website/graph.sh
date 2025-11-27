#terraform plan
#read -p "Press enter to continue..."
terraform graph > graph.txt
cat graph.txt
read -p "Press enter to continue..."
terraform graph | dot -Tsvg > graph.svg
read -p "Press enter to continue..."
xdg-open graph.svg
