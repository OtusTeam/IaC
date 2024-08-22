set -x
grep CONFIG_SECCOMP= /boot/config-$(uname -r)
# CONFIG_SECCOMP=y
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run --rm -it --security-opt seccomp=default.json alpine:3.20 sh -c whoami
docker run --rm -it --security-opt seccomp=default.json alpine:3.20 unshare --map-root-user --user sh -c whoami
docker run --rm -it --security-opt seccomp=unconfined   alpine:3.20 unshare --map-root-user --user sh -c whoami
