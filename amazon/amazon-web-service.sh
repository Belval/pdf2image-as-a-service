#!/bin/bash
# Create a virtualenv
virtualenv ./env/

# Source the virtualenv
source ./env/bin/activate

# Get account ID
echo "Please enter your account ID"
read ACCT_ID

# Install the provider's cli tool
pip install awscli

# Configure your installation

aws configure

# Create ssh key pair

aws ec2 create-key-pair --key-name aws-key --query 'KeyMaterial' --output text > aws-key.pem

aws ec2 describe-key-pairs --key-name aws-key

# Create security group

aws ec2 create-security-group --group-name pdf2image-demo-group --description "A demo group to deploy pdf2image as a service"

GROUP_ID=$(aws ec2 describe-security-groups --group-name pdf2image-demo-group --query "SecurityGroups[0].GroupId")
GROUP_ID=${GROUP_ID//\"}

aws ec2 describe-security-groups --group-id $GROUP_ID

# Create cluster

aws ecs create-cluster --cluster-name fargate-cluster

# Give all permission !

aws iam put-group-policy --group-name pdf2image-demo-group --policy-name pdf2image-demo-policy --policy-document file://amazon-ecs-full-access.json

aws iam attach-group-policy --group-name pdf2image-demo-group --policy-arn arn:aws:ecs:us-east-1:$ACCT_ID:cluster/fargate-cluster 

# Authorize SSH

aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0

# Authorize HTTP

aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0

VPC_ID=$(aws ec2 describe-security-groups --group-id $GROUP_ID --query "SecurityGroups[0].VpcId")
VPC_ID=${VPC_ID//\"}

# Create our subnet

#aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24

SUBNET_ID=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId")
SUBNET_ID=${SUBNET_ID//\"}

# Create our repository

aws ecr create-repository --repository-name pdf2image-demo-app

# Login the repository

aws ecr get-login --region us-east-1 --no-include-email

# Build docker image

docker build ../app -t pdf2image-demo-app

docker tag pdf2image-demo-app $ACCT_ID.dkr.ecr.us-east-1.amazonaws.com/pdf2image-demo-app

eval $(aws ecr get-login --no-include-email | sed 's|https://||')

docker push $ACCT_ID.dkr.ecr.us-east-1.amazonaws.com/pdf2image-demo-app

# Create an ECS task

aws ecs register-task-definition --cli-input-json file://pdf2image-demo-task-def.json

# Create a service

aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition pdf2image-demo:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$GROUP_ID]}"

# Run the task

aws ecs run-task --task-definition pdf2image-demo-app


