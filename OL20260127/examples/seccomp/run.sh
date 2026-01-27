set -x
grep CONFIG_SECCOMP= /boot/config-$(uname -r)
# Убеждаемся, что CONFIG_SECCOMP=y
read -p "press any key to continue..."
# используем профиль безопасности, но в нем не запрещены такие команды, как whoami:
docker run --rm -it --security-opt seccomp=default.json alpine:3.20 sh -c whoami
# используем профиль безопасности, но в нем запрещены такие команды, unshare 
# (unshare --map-root-user --user создает изолированное пользовательское пространство со своим root):
docker run --rm -it --security-opt seccomp=default.json alpine:3.20 unshare --map-root-user --user sh -c whoami
# не используем профиль безопасности, использование unshare не запрещено:  
docker run --rm -it --security-opt seccomp=unconfined   alpine:3.20 unshare --map-root-user --user sh -c whoami
set +x