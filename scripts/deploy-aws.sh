#!/bin/bash

# AWS Deployment Script - EC2 + RDS + ECS

echo "🚀 AWS Deployment Guide"
echo "======================="
echo ""

echo "Prerequisites:"
echo "1. AWS account with billing enabled"
echo "2. AWS CLI v2 installed"
echo "3. Docker installed locally"
echo ""

# Check AWS CLI
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Install from: https://aws.amazon.com/cli/"
    exit 1
fi

echo "🔐 Configuring AWS credentials..."
aws configure

echo ""
read -p "Enter your app name: " app_name
read -p "Enter AWS region (us-east-1/eu-west-1/ap-southeast-1): " region

if [ -z "$region" ]; then
    region="us-east-1"
fi

echo ""
echo "Creating AWS resources..."
echo ""

# Create ECR repository for Docker image
echo "📦 Creating ECR repository..."
aws ecr create-repository \
    --repository-name $app_name \
    --region $region || echo "Repository may already exist"

# Get ECR URI
ecr_uri=$(aws ecr describe-repositories \
    --repository-names $app_name \
    --region $region \
    --query 'repositories[0].repositoryUri' \
    --output text)

echo "ECR URI: $ecr_uri"
echo ""

# Login to ECR
echo "🔐 Logging into ECR..."
aws ecr get-login-password --region $region | \
    docker login --username AWS --password-stdin $ecr_uri

echo ""
echo "🐳 Building Docker image..."
docker build -t $app_name:latest .

echo ""
echo "📤 Tagging and pushing to ECR..."
docker tag $app_name:latest $ecr_uri:latest
docker push $ecr_uri:latest

echo ""
echo "✅ Image pushed to ECR!"
echo ""

cat > AWS_DEPLOYMENT_STEPS.md << EOF
# AWS Deployment Steps

## 1. Create RDS MongoDB Instance
\`\`\`bash
aws rds create-db-instance \\
    --db-instance-identifier text-app-mongodb \\
    --db-instance-class db.t3.micro \\
    --engine mongodb \\
    --master-username admin \\
    --master-user-password YourPassword123! \\
    --region $region
\`\`


## 2. Create ElastiCache Redis Cluster
\`\`\`bash
aws elasticache create-cache-cluster \\
    --cache-cluster-id text-app-redis \\
    --engine redis \\
    --cache-node-type cache.t3.micro \\
    --num-cache-nodes 1 \\
    --region $region
\`\`

## 3. Create ECS Cluster
\`\`\`bash
aws ecs create-cluster \\
    --cluster-name text-app-cluster \\
    --region $region
\`\`

## 4. Create Task Definition
\`\`\`bash
aws ecs register-task-definition \\
    --family text-app \\
    --network-mode awsvpc \\
    --requires-compatibilities FARGATE \\
    --cpu 256 \\
    --memory 512 \\
    --container-definitions '[{
        "name": "text-app",
        "image": "$ecr_uri:latest",
        "portMappings": [{
            "containerPort": 3000,
            "protocol": "tcp"
        }],
        "environment": [{
            "name": "NODE_ENV",
            "value": "production"
        }]
    }]' \\
    --region $region
\`\`

## 5. Create ECS Service
\`\`\`bash
aws ecs create-service \\
    --cluster text-app-cluster \\
    --service-name text-app-service \\
    --task-definition text-app \\
    --desired-count 1 \\
    --launch-type FARGATE \\
    --load-balancers targetGroupArn=arn:aws:elasticloadbalancing:...,containerName=text-app,containerPort=3000 \\
    --region $region
\`\`

## 6. Setup Load Balancer
Use AWS ELB console to:
- Create Application Load Balancer
- Configure target groups
- Setup SSL/TLS with ACM

## 7. Configure Domain
- Update Route 53 DNS records to point to ELB

## 8. Monitor & Scale
- Use CloudWatch for monitoring
- Configure Auto Scaling policies
- Set up SNS alerts

EOF

echo "📖 AWS deployment steps saved to AWS_DEPLOYMENT_STEPS.md"
echo ""
echo "✅ Docker image deployed to ECR!"
echo ""
echo "🔗 ECR Repository: $ecr_uri"
echo ""
echo "📋 Next steps (manual via AWS Console):"
echo "1. Create RDS MongoDB instance"
echo "2. Create ElastiCache Redis cluster"
echo "3. Create ECS cluster & service"
echo "4. Setup Application Load Balancer"
echo "5. Configure Route 53 DNS"
echo ""
echo "See AWS_DEPLOYMENT_STEPS.md for detailed commands"
echo ""
