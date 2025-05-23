#!/bin/bash
set -e

# Debug: Print important environment variables
echo "Starting deployment with parameters:"
echo "AWS_REGION=$AWS_REGION"
echo "STACK_NAME=$STACK_NAME"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "ECS_CLUSTER_NAME=$ECS_CLUSTER_NAME"
echo "ECS_CONTAINER_NAME=$ECS_CONTAINER_NAME"
echo "ECR_IMAGE_URI=$ECR_IMAGE_URI"
echo "CONTAINER_PORT=$CONTAINER_PORT"

# Check if ECR_IMAGE_URI is set
if [ -z "$ECR_IMAGE_URI" ]; then
  echo "ERROR: ECR_IMAGE_URI is not set. Exiting."
  exit 1
fi

echo "Deploying CloudFormation stack..."

aws cloudformation deploy \
  --template-file template.yaml \
  --stack-name "$STACK_NAME" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$AWS_REGION" \
  --parameter-overrides \
    AWSRegion="$AWS_REGION" \
    AWSAccountID="$ACCOUNT_ID" \
    ProjectName="$PROJECT_NAME" \
    ECRCluster="$ECS_CLUSTER_NAME" \
    ECRContainer="$ECS_CONTAINER_NAME" \
    ECSContainerImageURI="$ECR_IMAGE_URI" \
    ContainerPort="$CONTAINER_PORT"

echo "Deployment finished."
