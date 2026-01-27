#et -x
echo
echo "If you need to setup access to host devices,"
echo "use the [r|w|m] options to selectively"
echo "enable read, write, or mknod."
echo
set -x
# пытаемся в контейнере записать в устройство, которое было проброшено внутрь контейнера только для чтения:
docker run --rm --device=/dev/snd:/dev/snd:r alpine:3.20 sh -c "dd if=/dev/zero bs=4096 count=44100 of=/dev/snd/pcmC0D0p"
