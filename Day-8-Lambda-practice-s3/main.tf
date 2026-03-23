# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "my_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# S3 bucket Should be unique across all AWS accounts, so you may need to change the bucket name to something unique. You can add a random string or your name to ensure uniqueness.
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-krishna-12345678" 
}

# Lambda function
resource "aws_lambda_function" "my_lambda" {
  filename       = "lambda_function.zip"
  function_name  = "my-lambda-function"
  role           = aws_iam_role.lambda_role.arn
  handler        = "lambda_function.handler"
  runtime        = "python3.8"
}

# Upload the Lambda function code to S3
#key = the name (path) of the file inside S3
#etag is used to check if the file has changed, if it has not changed, it will not be uploaded again
#filemd5 is used to ensure that the file is only uploaded if it has changed
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"
  etag   = filemd5("lambda_function.zip")
}