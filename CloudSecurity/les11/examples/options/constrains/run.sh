echo Avoid DoS attacks by explicitly constraining the use of resources.
set -x
docker run --rm --cpus=0.5 --ulimit nofile=50 --ulimit nproc=50 --memory 128m --mount type=tmpfs,destination=/temp,tmpfs-size=100M myimage
# --restart=on-failure:5 conficts with --rm 
