output "instance_id" {
  value = aws_instance.ec2_anakdevops[*].id
}


# Output the public IP addresses of the EC2 instances
output "ec2_public_ips" {
  value = aws_instance.ec2_anakdevops[*].public_ip
}

