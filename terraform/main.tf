#provider as aws
provider "aws" {
    region      = "us-east-1"
}

#create a security group for RDS Database Instance
resource "aws_security_group" "rds_secgrptechchallenge" {
  name = "rds_secgrptechchallenge"
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

#create a RDS Database Instance
resource "aws_db_instance" "sqltechchallengeDb" {
  allocated_storage       =  10
  engine                  = "sqlserver-ex"
  engine_version          = "14.00.3381.6.v1"
  instance_class          = "db.t3.micro"
  # identifier              = "LancheRapidoBD"
  # name                    = "LancheRapidoBD"
  username                = "SA"
  password                = "Pa55w0rd2021"
  parameter_group_name    = "default.sqlserver-ex-14"
  vpc_security_group_ids  = ["${aws_security_group.rds_secgrptechchallenge.id}"]
  skip_final_snapshot     = true
  publicly_accessible     = true
}
