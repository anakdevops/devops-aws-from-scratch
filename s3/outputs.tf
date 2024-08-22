
# Output the bucket name to use in user data
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}