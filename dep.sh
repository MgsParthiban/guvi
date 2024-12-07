#!/bin/bash

source ./secret.txt
echo "$PASSWORD"
echo "$USERNAME" 
source ./.env

# Pull the Docker image and store the output
Image_name=$dockerimage

echo $Image_name

# Extract the tag from the image name line
#image=$(echo "$Image_name" | grep -oE "[^ ]+:[^ ]+" | tail -n 1 | awk '{print }')
#echo $image
dockerId=$(echo "$Image_name" | awk -F '/' '{print $1}')
prod_repo=$(echo "$dockerId/d2k")
tag=$(echo "$Image_name" | awk -F ':' '{print $2}')
prod_repo_tag=$(echo "$prod_repo:$tag")

echo "The dockerhub user Id is : $dockerId"
echo "The dockerhub user prod rename is : $prod_repo"
echo "The tag id is: $tag"
echo "the provate registry: $prod_repo_tag"

echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin


docker tag $Image_name $prod_repo_tag

sed -i '/^prod_image=/d' .env
echo "prod_image=$prod_repo_tag" >> .env


dockerCompose_path=$(find . -type f -name "docker-compose.yml")

# Get the directory containing the Dockerfile
dockerCompose_dir=$(dirname "$dockerCompose_path")

# Navigate to the directory
cd "$dockerCompose_dir" || exit

# Print the path of the Dockerfile
echo "Dockercompose found in: $(pwd)"

# Start the Docker Compose services
docker-compose --env-file .env up -d


docker push $prod_repo_tag
