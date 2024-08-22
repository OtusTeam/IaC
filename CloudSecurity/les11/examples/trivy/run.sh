set -x
docker pull aquasec/trivy:0.49.1
read -n 1 -s -r -p "press any key to continue..."; echo ""
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/yc-user/Library/Caches:/root/.cache/ aquasec/trivy:0.49.1 image python:3.4-alpine
