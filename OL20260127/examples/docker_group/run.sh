set -x
sudo usermod -aG docker $USER
newgrp docker
set +x