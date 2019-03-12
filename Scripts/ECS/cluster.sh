#!/bin/bash 
echo "ECS_CLUSTER=Vane_cluster" >> /etc/ecs/ecs.config;
#sudo sh Saltconfig.sh;
#sudo rm /etc/salt/minion;
#sudo echo 'master: 11.0.1.109' | sudo tee /etc/salt/minion;
sudo systemctl restart salt-minion;
sudo systemctl restart salt-minion;


