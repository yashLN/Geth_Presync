#!/bin/bash
echo "Download Dockercompose and geth services"

wget https://raw.githubusercontent.com/yashLN/Geth_Presync/main/dockercompose.yaml
wget https://raw.githubusercontent.com/yashLN/Geth_Presync/main/geth.service

echo "Apply the new service"
sudo cp dockercompose.yaml /var/tmp/dockercompose.yaml
sudo cp geth.service  /etc/systemd/system/geth.service
sudo systemctl daemon-reload

echo "Stopping the geth service"
sudo systemctl stop geth
docker rm geth-node
docker rmi public.ecr.aws/n2u0q7l0/geth:stable

echo "generating hex file"
openssl rand -hex 32 | tr -d "\n" > "jwt.hex"

sudo systemctl start geth
