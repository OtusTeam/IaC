set -x
export TRIVY="aquasec/trivy:0.68.2"
docker pull $TRIVY
read -p "press any key to continue..."
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /home/yc-user/Library/Caches:/root/.cache/ $TRIVY image python:3.4-alpine
docker image rm -f $TRIVY
