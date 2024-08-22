set -x
cat Dockerfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker build -t multi_stage_hello .
docker run --rm multi_stage_hello
