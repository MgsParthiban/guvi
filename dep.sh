#!/bin/bash

source ./secret.txt

# Pull the Docker image and store the output
Image_name=$dockerimage

echo $Image_name

# Extract the tag from the image name line
#image=$(echo "$Image_name" | grep -oE "[^ ]+:[^ ]+" | tail -n 1 | awk '{print }')
#echo $image
dockerId=$(echo "$Image_name" | awk -F '/' '{print $2}')
echo "The dockerhub user Id is : $dockerId"
