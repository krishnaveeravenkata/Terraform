# Day 1: Basic EC2 Instance Setup
resource "aws_instance" "day1_vm" {
  ami           = "ami-02dfbd4ff395f2a1b" # Standard Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "Day1-Instance"
  }
}