output "instance_id" {
  value = aws_instance.ec2_anakdevops[*].id
}


# Output the public IP addresses of the EC2 instances
output "ec2_public_ips" {
  value = aws_instance.ec2_anakdevops[*].public_ip
}

# Output the public IP addresses of the EC2 instances
output "ec2_private_ips" {
  value = aws_instance.ec2_anakdevops[*].private_ip
}

# Output the instance types and availability zones
output "ec2_instance_types" {
  value = [for instance in aws_instance.ec2_anakdevops : instance.instance_type]
  description = "The type of EC2 instances deployed."
}

output "ec2_availability_zones" {
  value = [for instance in aws_instance.ec2_anakdevops : instance.availability_zone]
  description = "The availability zones of the EC2 instances."
}