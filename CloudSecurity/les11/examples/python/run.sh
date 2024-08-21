set -x
cat Dockerfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker build -t mypython .
docker run mypython
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run python:3.12 python --version
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker images
