# Day 1: Basic EC2 Instance Setup
resource "aws_instance" "day1_vm" {
  ami           = "ami-02dfbd4ff395f2a1b" 
  instance_type = "t2.micro"
  
  tags = {
    Name = "Day1-Instance"
  }
}