#!/bin/bash
# Update and install Docker
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service
systemctl daemon-reload
usermod -aG docker $USER
newgrp docker
chmod 777 /var/run/docker.sock

# Enable Docker to start on boot
systemctl start docker
systemctl enable docker

# Pull and run nginx from Docker Hub
docker pull nginx:latest
docker run -d -p 80:80 --restart always --name webapp nginx:latest
