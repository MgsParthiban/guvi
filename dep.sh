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
docker push $prod_repo_tag
