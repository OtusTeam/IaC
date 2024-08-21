echo Do not use:
echo docker run --network=host
echo But instead create a dedicated network isolate the hosts network
echo
echo Do not use:
echo docker run --rm --device=/dev/snd:/dev/snd alpine:3.20
echo Unselected access to host devices.
echo
echo Do not use:
echo docker run -v /var/run/docker.sock:/var/ run/docker.sock myimage
echo Exposing the Docker socket is equivalent to
echo exposing an unrestricted root access to your host.
echo
echo Do not use:
echo docker run --privileged myimage
echo Which is giving your container root capabilities on the host.
echo
echo Do not use:
echo docker run --cgroup-parent myimage
echo By allowing shared resources with the host, you are putting it at risk.
echo
echo Do not use in Dockerfile:
echo FROM alpine:latest
echo ENV PASSWORD="my secret password"
echo ...
echo RUN unset PASSWORD
echo [REST_OF_YOUR_DOCKERFILE]
echo Note: unset do not remove PASSWORD completely !!!
echo
echo or a slightly better option, but also not without problems:
echo
echo FROM alpine:latest
echo ARG PASSWORD="my secret password"
echo [REST_OF_YOUR_DOCKERFILE]
