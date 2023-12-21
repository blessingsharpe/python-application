resource "aws_s3_bucket" "app_bucket" {
  bucket = "benny-app-bucket"
  acl    = "private"
}