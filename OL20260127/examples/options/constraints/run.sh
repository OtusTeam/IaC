echo Avoid DoS attacks by explicitly constraining the use of resources.
set -x
# пример ограничений (по использованию времени cpu, числу открываемых файлов, числу процессов, оперативной памяти, временной дисковой памяти), но ресурсов хватает для работы контейнера:
docker run --rm --cpus=0.5 --ulimit nofile=50 --ulimit nproc=50 --memory 006m --mount type=tmpfs,destination=/mnt,tmpfs-size=001M alpine:3.20 sh -c "dd if=/dev/zero of=/mnt/bigfile bs=1K count=512"
# пример ограничений, когда временной дисковой памяти будет не хватать для работы контейнера:
docker run --rm --cpus=0.5 --ulimit nofile=50 --ulimit nproc=50 --memory 100m --mount type=tmpfs,destination=/mnt,tmpfs-size=001M alpine:3.20 sh -c "dd if=/dev/zero of=/mnt/bigfile bs=1M count=007 && sleep 3600"
# пример ограничений, когда оперативной памяти будет не хватать для работы контейнера:
docker run --rm --cpus=0.5 --ulimit nofile=50 --ulimit nproc=50 --memory 006m --mount type=tmpfs,destination=/mnt,tmpfs-size=001G alpine:3.20 sh -c "dd if=/dev/zero of=/mnt/bigfile bs=1M count=200 && sleep 3600"
# --restart=on-failure:5 conficts with --rm 
