output "instance_id" {
  value = aws_instance.ec2_anakdevops_cicd[*].id
}


# Output the public IP addresses of the EC2 instances
output "ec2_public_ips" {
  value = aws_instance.ec2_anakdevops_cicd[*].public_ip
}

# Output the public IP addresses of the EC2 instances
output "ec2_private_ips" {
  value = aws_instance.ec2_anakdevops_cicd[*].private_ip
}

