# AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "my_rds_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "RDS_VPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_rds_igw" {
  vpc_id = aws_vpc.my_rds_vpc.id
  tags = {
    Name = "RDS_Internet_Gateway"
  }
}

# Create Route Table
resource "aws_route_table" "my_rds_route_table" {
  vpc_id = aws_vpc.my_rds_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_rds_igw.id
  }
  tags = {
    Name = "RDS_Route_Table"
  }
}

# Create Route Table Association for Subnet 1a
resource "aws_route_table_association" "my_rds_rta_1a" {
  subnet_id      = aws_subnet.my_rds_subnet_1a.id
  route_table_id = aws_route_table.my_rds_route_table.id
}

# Create Route Table Association for Subnet 1b
resource "aws_route_table_association" "my_rds_rta_1b" {
  subnet_id      = aws_subnet.my_rds_subnet_1b.id
  route_table_id = aws_route_table.my_rds_route_table.id
}

# Security group RDS Database Instance
resource "aws_security_group" "rds_secgrptechchallenge" {
  name = "rds_secgrptechchallenge"
  vpc_id = aws_vpc.my_rds_vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Database Instance
resource "aws_db_instance" "sqltechchallengeDb" {
  allocated_storage       = 20
  engine                  = "sqlserver-ex"
  engine_version          = "14.00.3475.1.v1"
  instance_class          = "db.t3.micro"
  username                = "SA"
  password                = var.db_password
  parameter_group_name    = "sqlserver-ex-14"
  vpc_security_group_ids  = [aws_security_group.rds_secgrptechchallenge.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  db_subnet_group_name    = aws_db_subnet_group.my_rds_subnet.name
}

# Create two subnets in different availability zones
resource "aws_subnet" "my_rds_subnet_1a" {
  vpc_id            = aws_vpc.my_rds_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "My_rds_Subnet_1a"
  }
}

resource "aws_subnet" "my_rds_subnet_1b" {
  vpc_id            = aws_vpc.my_rds_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "My_rds_Subnet_1b"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "my_rds_subnet" {
  name       = "my-rds-subnet-group"
  subnet_ids = [
    aws_subnet.my_rds_subnet_1a.id,
    aws_subnet.my_rds_subnet_1b.id
  ]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}
