output "instance_id" {
  value = aws_instance.ec2_anakdevops.id
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
