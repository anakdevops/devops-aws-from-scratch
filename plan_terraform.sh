#!/bin/bash



# Function to plan Terraform
terraform_plan() {
  local dir=$1
  echo "Planning Terraform in directory: $dir"
  cd "$dir" || exit
  terraform plan -var-file="../terraform.tfvars"
  cd - > /dev/null || exit
}







# Plan Terraform in all directories
terraform_plan "security_groups"
terraform_plan "s3"
terraform_plan "ec2-rancher"
terraform_plan "ec2-cicd"



echo "All Terraform commands executed successfully."
