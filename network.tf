# Key Pair for EC2 login
resource "aws_key_pair" "webapp_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = var.environment
  }
}

# Route Table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group for Web Application
resource "aws_security_group" "webapp_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for Docker web application"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Port ${port.value} access"
    }
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
  }
}