output "instance_id" {
  value = aws_instance.ec2_anakdevops[*].id
}


# Output the public IP addresses of the EC2 instances
output "ec2_public_ips" {
  value = aws_instance.ec2_anakdevops[*].public_ip
}

# Output the bucket name to use in user data
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}