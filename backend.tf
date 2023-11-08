# Create an S3 bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-eks-s3-bucket"
  acl = "private"  # Adjust the ACL as needed
}