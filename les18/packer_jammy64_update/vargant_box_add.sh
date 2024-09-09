set -x
vagrant box add jammy64/update output-vagrant/package.box
vagrant box list
rm -rf output-vagrant
