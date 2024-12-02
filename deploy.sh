#!/bin/bash

# Load secrets from the file
source ./secret.txt

DOCKER_HUB_IMAGE=$1


# Login to Docker Hub using the credentials
echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

#Image_name=read -p "Enter the image name:"
# Find the Dockerfile in subdirectories
dockerCompose_path=$(find . -type f -name "docker-compose.yml")

# Get the directory containing the Dockerfile
dockerCompose_dir=$(dirname "$dockerCompose_path")

# Navigate to the directory
cd "$dockerCompose_dir" || exit

# Print the path of the Dockerfile
echo "Dockercompose found in: $(pwd)"

# Start the Docker Compose services
docker-compose --env-file .env up -d
