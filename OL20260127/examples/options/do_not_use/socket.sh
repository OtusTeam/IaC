echo Do not use:
echo -e "\033[31m docker run -v /var/run/docker.sock:/var/ run/docker.sock myimage \033[0m"
echo Exposing the Docker socket is equivalent to
echo exposing an unrestricted root access to your host.
echo