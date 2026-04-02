terraform {
    backend "s3" {
       bucket = "dev-test-nareshit"
       key = "Day-6/terraform.tfstate"
       region = "ap-south-1"
       use_lockfile = "true"
    }
}