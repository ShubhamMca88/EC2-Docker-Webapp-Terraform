variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-0e35ddab05955cf57" # Ubuntu 22.04 LTS in ap-south-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "docker-webapp"
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
  default     = "webapp-key"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "./id_rsa.pub"
}

variable "volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp3"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "docker-webapp"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
  default     = "ap-south-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_ingress_ports" {
  description = "List of ingress ports to allow in the public security group"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "private_ingress_ports" {
  description = "List of ingress ports to allow in the private security group"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "health_check_path" {
  description = "Path for ALB health check"
  type        = string
  default     = "/"
}