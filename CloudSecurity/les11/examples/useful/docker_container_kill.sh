#!/bin/bash

IMAGE_NAME=$1

CONTAINER_ID=$(docker ps -aq --filter ancestor=$IMAGE_NAME)

if [ -n "$CONTAINER_ID" ]; then
  docker stop $CONTAINER_ID
  docker rm $CONTAINER_ID
  echo "Контейнер $IMAGE_NAME удален"
else
  echo "Контейнер $IMAGE_NAME не найден"
fi
