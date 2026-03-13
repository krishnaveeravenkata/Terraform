terraform {
  backend "s3" {
    bucket = "my-bucket-s3-terraform-fileupload"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}