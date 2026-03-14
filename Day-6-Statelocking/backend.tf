terraform {
  backend "s3" {
    bucket = "my-bucket-using-terraform-1"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}