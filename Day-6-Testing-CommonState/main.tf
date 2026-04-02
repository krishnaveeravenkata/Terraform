resource "aws_s3_bucket" "name" {
    bucket = var.my_bucket_name
}
variable "my_bucket_name" {
  default = "dev-test-naresit"
}