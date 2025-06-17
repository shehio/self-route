# Self-Route

This repository contains the infrastructure code for deploying a self-routing service using AWS ECS.

## Running Locally

To run the service locally:

```bash
./run-local.sh
```

This will build and run the Docker container, making the service available at:
```
http://localhost:5001/route/v1/driving/initial_point;final_point
```

## Running on AWS
### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform
- Docker

### Environment Setup

1. In the terminl
```bash
AWS_ACCOUNT_ID=your-aws-account-id-here
```

### Infrastructure Components

#### Terraform Configuration

The infrastructure is managed using Terraform and is organized into several files:

- `provider.tf`: AWS provider configuration
- `vpc.tf`: VPC, subnets, internet gateway, NAT gateway, and route tables
- `security.tf`: Security group configurations
- `ecs.tf`: ECS cluster, task definitions, and services
- `ecr.tf`: ECR repository and lifecycle policy
- `variables.tf`: Input variables for the infrastructure
- `outputs.tf`: Output values from the infrastructure

#### Key Resources

1. **VPC and Networking**
   - VPC with CIDR block 10.0.0.0/16
   - 2 public subnets (10.0.1.0/24, 10.0.2.0/24)
   - 2 private subnets (10.0.3.0/24, 10.0.4.0/24)
   - Internet Gateway for public internet access
   - NAT Gateway for private subnet internet access
   - Route tables for public and private subnets
   - Network ACLs for both public and private subnets

2. **Security**
   - Security group allowing all TCP traffic (for development purposes)
   - IAM roles for ECS tasks and instances

3. **Container Registry**
   - ECR repository for storing Docker images with lifecycle policy to keep the last 5 images

4. **Container Orchestration**
   - ECS cluster for running containers
   - Task definition with nginx container
   - ECS service for managing task deployment

### Deployment Process

1. **Initialize Terraform**
```bash
cd terraform
terraform init
```

2. **Plan the Infrastructure**
```bash
terraform plan
```

3. **Apply the Infrastructure**
```bash
terraform apply
```

4. **Build and Push Docker Image**
```bash
./push_image.sh
```

### Resource Dependencies

Terraform automatically determines the order of resource creation based on dependencies:

1. VPC and networking resources
2. Security groups and IAM roles
3. ECR repository
4. ECS cluster and task definition
5. Auto Scaling Group and EC2 instances
6. ECS service

### Outputs

The infrastructure provides several useful outputs:

- VPC ID and subnet IDs
- ECS cluster name and ARN
- ECS service name
- Task definition details
- ECR repository URL and ARN

### Maintenance

- The ECR repository is configured to keep the last 5 images
- The Auto Scaling Group maintains the desired number of instances
- The ECS service ensures the desired number of tasks are running

### Security Considerations

- The current security group allows all TCP traffic (for development)
- In production, you should restrict the security group to specific ports and sources
- Consider using AWS Secrets Manager for sensitive data
- Review and update IAM roles with least privilege principles

### Cleanup

To destroy the infrastructure:

```bash
cd terraform
terraform destroy
```

Note: This will remove all resources created by Terraform. Make sure to backup any important data first. 