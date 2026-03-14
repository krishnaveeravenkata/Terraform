resource "aws_vpc" "name"   {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name="K-VPC"
    }
}
  resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "prod"
    }
}
  resource "aws_subnet" "prod_subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
    Name = "prod-subnet"
    }
} 