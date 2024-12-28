#!/bin/bash

# Download & install Docker using the convenience script
echo "Checking docker installation"
if ! command -v docker &> /dev/null; then
        echo "Docker not installed, installing docker"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        echo "Docker installed"
else
        echo "Docker already installed"
fi

# Setup ufw for 1194/udp
#echo "Checking port 1194/udp on ufw"
#if ! sudo ufw status | grep -qw 1194$; then
#        echo "Port 1194/udp is not added, adding port 1194/udp"
#        sudo ufw allow 1194/udp
#fi
#echo "Port 1194/udp allowed"

#echo "Checking ufw status"
#if sudo ufw status | grep -qw inactive$; then
#        echo "ufw is inactive, enabling ufw"
#        yes y | sudo ufw enable
#fi
#echo "ufw is active"

# Disable ufw
sudo ufw disable

# Delete existing container of brinx
sudo docker container rm -f brinxai_relay

# Create and run brinx container
sudo docker run -d --name brinxai_relay --cap-add=NET_ADMIN -p 1194:1194/udp -it --privileged admier/brinxai_nodes-relay:latest
