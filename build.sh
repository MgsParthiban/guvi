#!/bin/bash

source ./secret.txt
DOCKER_TAG=$1


build_number=${BUILD_NUMBER:-"latest"}

image_tag="$DOCKER_TAG:$build_number"


# Find the Dockerfile in subdirectories
dockerfile_path=$(find . -type f -name "Dockerfile")

# Get the directory containing the Dockerfile
dockerfile_dir=$(dirname "$dockerfile_path")

# Navigate to the directory
cd "$dockerfile_dir" || exit

# Print the path of the Dockerfile
echo "Dockerfile found in: $(pwd)"

# Execute the docker build command
docker build -t $image_tag .

echo "Docker image built with tag: $image_tag"

docker login

echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

docker push $image_tag
