#!/bin/bash
set -e

echo "===== Starting ECS Fargate Deployment ====="

# Print parameter values
echo "AWS_REGION      = $AWS_REGION"
echo "ACCOUNT_ID      = $ACCOUNT_ID"
echo "STACK_NAME      = $STACK_NAME"
echo "PROJECT_NAME    = $PROJECT_NAME"
echo "ECS_CLUSTER_NAME= $ECS_CLUSTER_NAME"
echo "ECS_CONTAINER_NAME = $ECS_CONTAINER_NAME"
echo "ECR_IMAGE_URI   = $ECR_IMAGE_URI"
echo "CONTAINER_PORT  = ${CONTAINER_PORT:-3000}"

# Validate required variables
if [ -z "$AWS_REGION" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$STACK_NAME" ] || \
   [ -z "$PROJECT_NAME" ] || [ -z "$ECS_CLUSTER_NAME" ] || \
   [ -z "$ECS_CONTAINER_NAME" ] || [ -z "$ECR_IMAGE_URI" ]; then
  echo " ERROR: One or more required environment variables are missing."
  echo "Make sure all of the following are set:"
  echo "AWS_REGION, ACCOUNT_ID, STACK_NAME, PROJECT_NAME, ECS_CLUSTER_NAME, ECS_CONTAINER_NAME, ECR_IMAGE_URI"
  exit 1
fi

# Default value for container port
CONTAINER_PORT=${CONTAINER_PORT:-3000}

echo " Deploying CloudFormation stack: $STACK_NAME"

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

echo "✅ Deployment completed successfully."
