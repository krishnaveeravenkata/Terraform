# ------------------------------
# VPC
# ------------------------------
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "my-vpc"
    Description = "VPC for RDS instance"
  }
}

# ------------------------------
# Subnets
# ------------------------------
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "subnet1"
    Description = "First subnet for RDS"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name        = "subnet2"
    Description = "Second subnet for RDS"
  }
}

# ------------------------------
# DB Subnet Group
# ------------------------------
resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name        = "my-subnet-group"
    Description = "Subnet group for my RDS instance"
  }
}

# ------------------------------
# Security Groups
# ------------------------------

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound
  }

  tags = {
    Name = "ec2-sg"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # Only EC2 can connect
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# ------------------------------
# RDS Instance
# ------------------------------
resource "aws_db_instance" "mydb" {
  identifier                = "mydatabase"
  engine                    = "mysql"
  engine_version            = "8.0"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  storage_type              = "gp2"
  username                  = "dbadmin"
  manage_master_user_password = true
  db_subnet_group_name      = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]

  publicly_accessible       = false
  skip_final_snapshot       = true

  tags = {
    Name        = "mydatabase"
    Description = "My RDS instance with managed secrets"
  }
}

# ------------------------------
# EC2 Instance
# ------------------------------
resource "aws_instance" "name" {
  ami                    = "ami-02dfbd4ff395f2a1b" # Amazon Linux 2
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = "MyEC2Instance"
    Description = "EC2 instance to connect to RDS"
  }
}

# ------------------------------
# Internet Gateway & Route Table
# ------------------------------
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name        = "my-internet-gateway"
    Description = "Internet gateway for my VPC"
  }
}

resource "aws_route_table" "name" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "subnet1_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.name.id
}

resource "aws_route_table_association" "subnet2_assoc" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.name.id
}
