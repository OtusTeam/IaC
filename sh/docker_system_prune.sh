set -x
read -p "Press any key to docker system prune (all images, build cache and other unuset objects)..." 
docker system prune -a --volumes --force
set +x