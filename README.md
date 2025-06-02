# EC2 Docker Web Application Terraform Project

This project provides infrastructure as code (IaC) for deploying a containerized web application on AWS EC2 using Terraform.

## Project Overview

This Terraform configuration automatically provisions and configures:

- AWS EC2 instance running Ubuntu 22.04 LTS in a private subnet
- Application Load Balancer (ALB) in a public subnet
- Docker engine installed via user_data script
- Nginx web server running in a Docker container
- Complete networking setup with VPC, public/private subnets, NAT gateway, and internet gateway
- Security groups with proper inbound/outbound rules
- SSH key pair for secure instance access

## Architecture Components

- **Compute**: t2.micro EC2 instance (configurable) in private subnet
- **Load Balancing**: Application Load Balancer in public subnet
- **Networking**: Custom VPC with public and private subnets, NAT gateway
- **Security**: Separate security groups for public and private resources
- **Storage**: 8GB encrypted EBS volume (configurable)
- **Container**: Nginx web server running in Docker
- **Access**: SSH key-based authentication via bastion host (not included)

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed (version >= 1.0.0)
- AWS CLI configured with valid credentials
- SSH key pair (can be generated using the instructions below)

## Quick Start

1. Clone this repository
2. Generate an SSH key pair if you don't have one:
   ```
   ssh-keygen -t rsa -b 4096 -f ./id_rsa
   ```
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Review the deployment plan:
   ```
   terraform plan
   ```
5. Apply the configuration:
   ```
   terraform apply
   ```
6. Access your web application using the output URL

## Configuration Options

You can customize the deployment by modifying the `terraform.tfvars` file or by providing variable values at runtime:

```
terraform apply -var="instance_type=t2.small" -var="environment=staging"
```

### Key Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `instance_type` | EC2 instance size | t2.micro |
| `region` | AWS region | ap-south-1 |
| `environment` | Deployment environment | dev |
| `volume_size` | Root volume size in GB | 8 |
| `ingress_ports` | Allowed inbound ports | [22, 80, 443] |

## Project Structure

```
ec2-instance-tf/
├── main.tf          # EC2 instance configuration
├── network.tf       # VPC, subnet, security group configuration
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── providers.tf     # Provider configuration
├── docker_webapp.sh # User data script for Docker installation
└── README.md        # This file
```

## Outputs

After successful deployment, Terraform will output:
- Instance ID
- Public IP address
- Public DNS name
- Web application URL

## Cleanup

To destroy all resources created by this configuration:

```
terraform destroy
```

## Security Considerations

- The security group allows SSH access from any IP (0.0.0.0/0). For production, restrict this to your IP range.
- The EC2 instance uses an encrypted EBS volume for enhanced security.
- SSH key-based authentication is used instead of passwords.

## License

This project is licensed under the MIT License - see the LICENSE file for details.