#!/bin/bash

source ./secret.txt

# Pull the Docker image and store the output
Image_name=$dockerimage
# Extract the tag from the image name line
image=$(echo "$Image_name" | grep -oE "[^ ]+:[^ ]+" | tail -n 1 | awk '{print }')

dockerId=$(echo "$image" | awk -F '/' '{print $2}')
private_repo=$(echo "$dockerId/d2k")
repo_name=$(echo "$image" | awk -F '/' '{ print $3}' | awk -F ':' '{print $1}')
tag=$(echo "$image" | awk -F ':' '{print $2}')

echo "this si the docker id: $image"
echo "this si the docker id: $dockerId"
echo "this si the docker id: $repo_name"
echo "this si the docker id: $tag"
echo "this si the docker id:$private_repo"

#echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin --debug

echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

dockerCompose_path=$(find . -type f -name "docker-compose.yml")

# Get the directory containing the Dockerfile
dockerCompose_dir=$(dirname "$dockerCompose_path")

# Navigate to the directory
cd "$dockerCompose_dir" || exit

# Print the path of the Dockerfile
echo "Dockercompose found in: $(pwd)"

# Start the Docker Compose services
docker-compose --env-file .env up -d

docker tag $image $private_repo:$tag

docker push $private_repo:$tag
