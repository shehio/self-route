#!/bin/bash
if [ -z "$AWS_ACCOUNT_ID" ]; then
    echo "Error: AWS_ACCOUNT_ID environment variable is not set in the environment"
    exit 1
fi

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com

# Build and push the image
docker build -t osrm:latest .
docker tag osrm:latest ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/osrm:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/osrm:latest