#!/bin/bash
set -e

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
    ImageUri="$ECR_IMAGE_URI" \
    ContainerPort="$CONTAINER_PORT"
