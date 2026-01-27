echo Limit the mounted root filesystem to be read-only.
echo Provide an in-memory storage for temporary files at /tmp /run /var/log.
echo Bind your local partition /usr/local/bin using the read-only option too.
set -x
# C опицей --read-only файловая система контейнера (корневой /) монтируется в режиме только для чтения. 
# Процессы не смогут записывать в /, создавать файлы/папки или менять существующие файлы в корневой FS
# Из‑за --read-only приложениям нужен writable путь для временных/логовых данных — /tmp, /run, /var/log) 
# делаем их с помощью tmpfs, но при этом noexec — выполнение бинарников в них запрещено, 
# а nosuid (игнорирование SUID/SGID битов) не позволяет повысить привилегии через setuid-программы.
docker run --rm --read-only --tmpfs /tmp:rw,noexec,nosuid --tmpfs /run:rw,noexec,nosuid --tmpfs /var/log:rw,noexec,nosuid alpine:3.20 sh -c "mount | grep tmpfs && dd if=/dev/zero of=/file bs=1M count=1" 
# Пробрасываем внутрь контейнера каталог в режиме только для чтения:
docker run --rm -v /usr/local/bin:/app/:ro alpine:3.20 sh -c "dd if=/dev/zero of=/app/file bs=1M count=1"
