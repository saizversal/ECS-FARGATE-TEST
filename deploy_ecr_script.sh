#!/bin/bash
set -e

echo "Building Docker image..."
docker build -t $ECR_REPOSITORY:$IMAGE_TAG ..

echo "Tagging image..."
docker tag $ECR_REPOSITORY:$IMAGE_TAG $ECR_IMAGE_URI

echo "Pushing image to ECR..."
docker push $ECR_IMAGE_URI
