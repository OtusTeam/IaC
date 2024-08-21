set -x
cat Dockerfile
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker build -t printenv .
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --rm --env MY_ENV_VAR=my_value printenv

