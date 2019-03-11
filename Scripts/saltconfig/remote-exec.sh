#!/bin/bash
"sudo sh Saltconfig.sh";
"sudo rm /etc/salt/minion";
"sudo rm /etc/salt/master";
"sudo echo 'interface: 0.0.0.0' | sudo tee /etc/salt/master";
"sudo echo 'master: 11.0.1.109' | sudo tee /etc/salt/minion";
"sudo systemctl restart salt-minion";
"sudo systemctl restart salt-master";
#"sudo mkdir /srv/salt";
#"sudo mv /home/ec2-user/jenkins_installation.sls /srv/salt";
#"sudo salt-key -L";
#"sudo salt-key -A -y";
    