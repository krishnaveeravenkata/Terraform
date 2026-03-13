resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "My-vpc"
    }
  
}

resource "aws_instance" "name" {
  ami           = "ami-02dfbd4ff395f2a1b"  # Amazon Linux 2 AMI in us-east-1
  instance_type = "t3.small"                # Free Tier eligible
  tags = {
    Name = "my-vpc-instance"
  }
}
