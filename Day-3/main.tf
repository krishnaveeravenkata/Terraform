resource "aws_instance" "dev_instance" {
  provider      = aws.dev
  ami           = "ami-02dfbd4ff395f2a1b"  # us-east-1
  instance_type = "t3.micro"
  tags = {
    Name = "DevInstance"
  }
}

resource "aws_instance" "prod_instance" {
  provider      = aws.prod
  ami           = "ami-0f559c3642608c138"  # ap-south-1
  instance_type = "t3.micro"
  tags = {
    Name = "ProdInstance"
  }
}