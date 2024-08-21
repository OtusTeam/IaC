#et -x
echo
echo "If you need to setup access to host devices,"
echo "use the [r|w|m] options to selectively"
echo "enable read, write, or mknod."
echo
set -x
docker run --rm --device=/dev/snd:/dev/snd:r alpine:3.20
