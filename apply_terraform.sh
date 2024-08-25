#!/bin/bash




# Function to apply Terraform
terraform_apply() {
  local dir=$1
  echo "Applying Terraform in directory: $dir"
  cd "$dir" || exit
  terraform apply -var-file="../terraform.tfvars" -auto-approve
  cd - > /dev/null || exit
}





# Plan Terraform in all directories
terraform_apply "security_groups"
terraform_apply "s3"
terraform_apply "ec2-rancher"
terraform_apply "ec2-cicd"



echo "All Terraform commands executed successfully."
