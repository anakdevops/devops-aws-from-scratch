output "security_group_id" {
  value = aws_security_group.anakdevops_sg.id
}

output "key_pair_id" {
  value = aws_key_pair.key_pair.id
}

output "key_public_key" {
  value = aws_key_pair.key_pair.public_key
}

