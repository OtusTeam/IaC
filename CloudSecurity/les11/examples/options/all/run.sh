echo Example of using all options:
set -x
docker network create web
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --rm \
 --security-opt no-new-privileges \
 --cap-drop=ALL \
 --cap-add=NET_BIND_SERVICE \
 -p 8080:80 \
 --cpus=0.5 \
 --ulimit nofile=50 \
 --ulimit nproc=50 \
 --memory 128m \
 --read-only \
 --tmpfs /tmp:rw,noexec,nosuid \
 -v /usr/local/myapp:/app/:ro \
 --network=web \
 myimage
# Also it is recommended to export your logs to an external service:
# --log-driver=<logging driver> \
