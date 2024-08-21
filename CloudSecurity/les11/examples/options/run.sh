echo Do not use:
echo docker run --privileged
echo Which is giving your container root capabilities on the host:
echo docker run --cgroup-parent
echo By allowing shared resources with the host, you are putting it at risk.
echo
echo Do not use:
echo docker run --network= host
echo But instead create a dedicated network isolate the host s network interface:
set -x
docker network create web
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --name myapp --rm  -u 4000:4000 \
# Drop all the capabilities and only add those necessary: \
 --security-opt no-new-privileges \
 --cap-drop=ALL \
# here we add NET_BIND_SERVICE to bind to a port under1024 like 80: \
 --cap-add=NET_BIND_SERVICE \
 -p 8080:80 \
# Avoid DoS attacks by explicitly constraining the use of resources.
 --cpus=0.5 \
 --restart=on-failure:5 \
 --ulimit nofile=5 \
 --ulimit nproc=5 \
 --memory 128m \
# Limit the mounted filesystem to be read-only.
# Provide an in-memory storage for temporary files at /tmp.
# Bind your local partition /usr/local/myapp using the read-only option too.
# You can also create a read-only bind mount:
 --read-only \
 --tmpfs /tmp:rw,noexec,nosuid \
 -v /usr/local/myapp:/app/:ro \
 --bridge=none \
# Disable the default bridge and use a dedicated network to expose the host interface.
 --network=web \
# It is recommended to export your logs to an external service:
# --log-driver=<logging driver> \
 myimage
