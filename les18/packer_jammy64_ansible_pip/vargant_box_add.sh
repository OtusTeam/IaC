set -x
vagrant box add jammy64/ansible output-vagrant/package.box
vagrant box list
rm -rf output-vagrant
