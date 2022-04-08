resource "aws_s3_bucket" "hello-world-bucket" {
  bucket = "avinashkris9-s3-hello-world"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}