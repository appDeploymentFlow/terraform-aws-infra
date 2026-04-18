#!/bin/bash
for i in {1..10}; do
  ping -c 1 google.com && break || sleep 5
done
sudo apt update && sudo apt install -y ansible
##change deafult user ubuntu password to login with password
sudo echo 'ubuntu:rootme@123'|sudo chpasswd
##enable password authentication so that instance can accept password
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
##disable public key authentication so that while login it match password not public key
sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config
##Change to yes to enable challenge-response passwords
sudo sed -i 's/^KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
#sudo systemctl restart ssh
systemctl daemon-reload
systemctl restart ssh.socket

##add virtual memory
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0'| sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10