#!/bin/bash -xe
wget -O - https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/saltstack.list
sudo apt update
sudo apt-get install salt-master -y
sudo apt-get install salt-minion -y
echo "interface: 0.0.0.0" >> /etc/salt/master
echo "master: 0.0.0.0" >> /etc/salt/minion
sudo systemctl restart salt-master
sudo systemctl restart salt-minion