set -x
# Демонстрация пользователя в контейнере по умолчанию (root) и как рекомендуется (обычный пользователь, не root!) 

# пользователь в контейнере по умолчанию (root)
docker run --rm alpine:3.20 id
read -p "press any key to continue..."
# рекомендуется (обычный пользователь, не root!)
cat Dockerfile
read -p "press any key to continue..."
docker build -t myimage .
docker run --rm myimage
docker image rm -f myimage