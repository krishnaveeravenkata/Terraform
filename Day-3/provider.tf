provider "aws" {
  alias   = "dev"
  profile = "default"
  region  = "us-east-1"
}
provider "aws" {
  alias   = "prod"
  profile = "default"
  region  = "ap-south-1"
}