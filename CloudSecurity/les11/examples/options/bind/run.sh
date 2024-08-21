echo Drop all the capabilities and only add those necessary
echo but we add NET_BIND_SERVICE to bind to a port under1024 like 80: 
set -x
docker run --rm  --security-opt no-new-privileges --cap-drop=ALL --cap-add=NET_BIND_SERVICE -p 8080:80 myimage
