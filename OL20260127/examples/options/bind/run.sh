echo Drop all the capabilities and only add those necessary
echo but we add NET_BIND_SERVICE to bind to a port under1024 like 80: 
set -x
# сборсим все привелегии и добавим только нужную: NET_BIND_SERVICE для привязки портов ниже 1024 (в частности, порта 80),
# с помощью nc в 80 порт будем выводить hello:
docker run --rm -d --name bind --security-opt no-new-privileges --cap-drop=ALL --cap-add=NET_BIND_SERVICE -p 127.0.0.1:8080:80 alpine:3.20 \
   sh -c 'while true; do printf "HTTP/1.1 200 OK\r\nContent-Length: 5\r\nContent-Type: text/plain\r\n\r\nhello" | nc -l -p 80; done'
sleep 5

# на порту 8080 (внутри контейнера это порт 80) должно выводится hello:
curl http://127.0.0.1:8080 

# стопим контейнер:
docker stop bind
set +x 
