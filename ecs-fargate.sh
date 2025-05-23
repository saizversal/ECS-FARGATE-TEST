#!/bin/bash
set -e

echo "Deploying CloudFormation stack..."
aws cloudformation deploy \
  --template-file template.yaml \
  --stack-name $PROJECT_NAME-stack \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    AWSRegion=$AWS_REGION \
    AWSAccountID=$ACCOUNT_ID \
    ProjectName=$PROJECT_NAME \
    ECRCluster=$ECS_CLUSTER_NAME \
    ECRContainer=$ECS_CONTAINER_NAME \
    ECSContainerImageURI=$ECR_IMAGE_URI \
    ContainerPort=3000
