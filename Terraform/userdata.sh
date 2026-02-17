#!/bin/bash
# 1. System updates and Docker installation (for Amazon Linux 2023)
dnf update -y
dnf install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

# 2. Authenticate Docker with your AWS ECR
# REPACE 'YOUR_ACCOUNT_ID' and 'us-east-1' if you are using a different region
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 732517664789.dkr.ecr.eu-north-1.amazonaws.com
# 3. Pull the Docker image from your ECR repository
docker pull 732517664789.dkr.ecr.eu-north-1.amazonaws.com/my-webapp:latest

# 4. Run the Docker container, mapping port 80 of the container to port 80 of the EC2 instance
docker run -d -p 80:80 732517664789.dkr.ecr.eu-north-1.amazonaws.com/my-webapp:latest