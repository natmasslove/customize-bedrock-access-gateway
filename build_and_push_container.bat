@echo off
REM Get the AWS account ID and region
FOR /F "tokens=*" %%i IN ('aws sts get-caller-identity --query Account --output text') DO SET AWS_ACCOUNT_ID=%%i
FOR /F "tokens=*" %%i IN ('aws configure get region') DO SET AWS_REGION=%%i

REM Define the repository and image name
SET REPO_NAME=customized-bedrock-gateway-container
SET IMAGE_NAME=%AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%REPO_NAME%

REM Build the Docker image with additional options
cd src
docker build --progress=plain --platform linux/arm64 -f Dockerfile_ecs -t %IMAGE_NAME% .
cd ..

REM Login to AWS ECR
aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com

REM Push the Docker image to ECR
docker push %IMAGE_NAME%

@echo Docker image for ECS Gateway pushed to: %IMAGE_NAME%
pause
