set -x
# Демонстрация того, как радикально сократить образ за счет применения multi stage сборки образа контейнера

# скачиваем базовый образ
docker pull golang:1.21
# смотрим, в чем заключается multi stage сборка в тексте Dockerfile
cat Dockerfile
read -p "press any key to continue..."
# собираем 
docker buildx build -t multi_stage_hello .
# запускаем
docker run --rm multi_stage_hello
# сравниваем размеры базового и получившегося образов
docker images
read -p "press any key to continue..."
# убираем за собой
docker image rm -f multi_stage_hello
docker image rm -f golang:1.21
set +x
