echo Do not use:
echo -e "\033[31m docker run --network=host myimage \033[0m"
echo But instead create a dedicated network isolate the hosts network
echo
echo Do not use:
echo -e "\033[31m docker run --rm --device=/dev/snd:/dev/snd myimage \033[0m"
echo Unselected access to host devices!
echo As other sensitive points: / /proc /sys ...
echo
echo Do not use:
echo -e "\033[31m docker run -v /var/run/docker.sock:/var/ run/docker.sock myimage \033[0m"
echo Exposing the Docker socket is equivalent to
echo exposing an unrestricted root access to your host.
echo
echo Do not use:
echo -e "\033[31m docker run --privileged myimage \033[0m"
echo Which is giving your container root capabilities on the host.
echo
echo Do not use:
echo -e "\033[31m docker run --cgroup-parent myimage \033[0m"
echo By allowing shared resources with the host, you are putting it at risk.
echo
echo Do not use in Dockerfile:
echo -e "\033[31m FROM alpine:latest \033[0m"
echo -e "\033[31m ENV PASSWORD=secret \033[0m"
echo -e "\033[31m ... \033[0m"
echo -e "\033[31m RUN unset PASSWORD \033[0m"
echo -e "\033[31m [REST_OF_YOUR_DOCKERFILE] \033[0m"
echo Note: unset do not remove PASSWORD completely !!!
echo
echo or a slightly better option, but also not without problems:
echo -e "\033[31m FROM alpine:latest \033[0m"
echo -e "\033[31m ARG PASSWORD=secret \033[0m"
echo -e "\033[31m [REST_OF_YOUR_DOCKERFILE] \033[0m"
