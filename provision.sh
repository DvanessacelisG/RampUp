#!/bin/bash
echo "Installing Java"
sudo apt-get -y install default-jre > /dev/null 2>&1
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install express express-jwt auth0-api-jwt-rsa-validation --save

echo "Success"
