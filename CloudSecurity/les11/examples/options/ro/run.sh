echo Limit the mounted filesystem to be read-only.
echo Provide an in-memory storage for temporary files at /tmp.
echo Bind your local partition /usr/local/myapp using the read-only option too.
echo You can also create a read-only bind mount:
set -x
docker run --rm --read-only --tmpfs /tmp:rw,noexec,nosuid -v /usr/local/myapp:/app/:ro myimage
