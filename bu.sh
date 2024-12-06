#!/bin/bash

echo "Current directory: $(pwd)" 
# Source the .env file and check if it loads correctly
source ./.env

image_name=$DOCKER_HUB_IMAGE

echo "$image_name"

build_number=${BUILD_NUMBER:-"latest"}

dockerfile_path=$(find . -type f -name "Dockerfile")

# Get the directory containing the Dockerfile
dockerfile_dir=$(dirname "$dockerfile_path")

# Navigate to the directory
cd "$dockerfile_dir" || exit

# Print the path of the Dockerfile
echo "Dockerfile found in: $(pwd)"

# Execute the docker build command
docker build -t $image_name .

echo "Docker image built with tag: $image_name"

sed -i '/^dockerimage=/d' .env
echo "dockerimage=$image_name" >> .env