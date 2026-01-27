set -x
# Демонстрация, как распределение одних и тех же действий по слоям приводит либо к объемному образу, либо к компактому образу

# создаем многослойный образ (7 слоев): 
cat fat/Dockerfile
read -p "press any key to continue..."
docker build -t fat fat
docker run fat
# создаем малослойные образ (7 слоев): 
cat thin/Dockerfile
read -p "press any key to continue..."
docker build -t thin thin
# функционально образы мало отличаются:
docker run thin
#docker run python:3.12 python --version

# а вот по размеру:
docker images
read -p "press any key to continue..."
docker image rm -f thin
docker image rm -f fat
#docker image rm -f python:3.12
set +x

