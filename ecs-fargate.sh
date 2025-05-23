#!/bin/bash
set -e

echo "Starting deployment..."

# Debug print to verify environment variables
echo "AWS_REGION=$AWS_REGION"
echo "STACK_NAME=$STACK_NAME"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "ECS_CLUSTER_NAME=$ECS_CLUSTER_NAME"
echo "ECS_CONTAINER_NAME=$ECS_CONTAINER_NAME"
echo "ECR_IMAGE_URI=$ECR_IMAGE_URI"
echo "CONTAINER_PORT=$CONTAINER_PORT"

if [ -z "$ECR_IMAGE_URI" ]; then
  echo "ERROR: ECR_IMAGE_URI is not set. Exiting."
  exit 1
fi

aws cloudformation deploy \
  --template-file template.yaml \
  --stack-name "$STACK_NAME" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$AWS_REGION" \
  --parameter-overrides \
    AWSRegion="$AWS_REGION" \
    AWSAccountID="$ACCOUNT_ID" \
    ProjectName="$PROJECT_NAME" \
    ECSClusterName="$ECS_CLUSTER_NAME" \
    ECSContainerName="$ECS_CONTAINER_NAME" \
    ECSContainerImageURI="$ECR_IMAGE_URI" \
    ContainerPort="$CONTAINER_PORT"

echo "Deployment finished."
