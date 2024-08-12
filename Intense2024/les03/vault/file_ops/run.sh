set -x
rm test.txt
echo use INSERT to insert text, ESC to escape text, SHIFT+: to command, wq to write and quit or qa to quit w/o changes
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-vault create test.txt
cat test.txt
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-vault edit test.txt
ansible-vault view test.txt
read -n 1 -s -r -p "press any key to continue..."; echo ""
ansible-vault rekey test.txt
ansible-vault view test.txt
rm test.txt
