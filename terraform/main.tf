# AWS provider
provider "aws" {
    region      = "us-east-1"
}

# Create VPC --remover-- teste
resource "aws_vpc" "my_rds_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "RDS_VPC"
  }
}

# Security group RDS Database Instance
resource "aws_security_group" "rds_secgrptechchallenge" {
  name = "rds_secgrptechchallenge"

  # inicio teste da VPC --remover--
  vpc_id = aws_vpc.my_rds_vpc.id  # Referencia a VPC
  # --remover--

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
  allocated_storage       =  20
  engine                  = "sqlserver-ex"
  engine_version          = "14.00.3475.1.v1"
  instance_class          = "db.t3.micro"
  username                = "SA"
  password                = var.db_password
  parameter_group_name    = "sqlserver-ex-14"
  vpc_security_group_ids  = ["${aws_security_group.rds_secgrptechchallenge.id}"]
  skip_final_snapshot     = true
  publicly_accessible     = true


  # teste da subnet vpc --remover--
  db_subnet_group_name    = aws_db_subnet_group.my_rds_subnet.name  # Adicionar um grupo de sub-rede
}


# --remover-- Daqui pra baixo tudo teste de rede
# Criar um grupo de sub-rede para a VPC
resource "aws_subnet" "my_rds_subnet" {
  vpc_id            = aws_vpc.my_rds_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1"  # --remover--Tirei o a no final (us-east-1a)
  tags = {
    Name = "My_rds_Subnet"
  }
}

resource "aws_db_subnet_group" "my_rds_subnet" {
  name       = "my-rds-subnet-group"
  subnet_ids = [aws_subnet.my_rds_subnet.id]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}
