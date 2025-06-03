#!/bin/bash

sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable --now docker
sudo systemctl restart docker
sudo docker run hello-world

