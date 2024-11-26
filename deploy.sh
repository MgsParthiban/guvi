#!/bin/bash

# Load secrets from the file
source ./secret.txt

# Login to Docker Hub using the credentials
echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

# Start the Docker Compose services
docker-compose up -d
