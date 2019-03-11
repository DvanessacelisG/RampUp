#!/bin/bash -xe
#wget -O - https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -;
#echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" >> /etc/apt/sources.list.d/saltstack.list; 
#sudo apt update; 
#sudo apt-get install salt-master -y;
#sudo apt-get install salt-minion -y;
sudo yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm -y;
sudo yum clean expire-cache;
sudo yum install salt-master -y;
sudo yum install salt-minion -y;
sudo yum install salt-ssh -y;
sudo yum install salt-api -y;
sudo systemctl restart salt-minion;
sudo systemctl restart salt-master;