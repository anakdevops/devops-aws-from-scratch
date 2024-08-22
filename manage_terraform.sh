#!/bin/bash

# Function to initialize Terraform
terraform_init() {
  local dir=$1
  echo "Initializing Terraform in directory: $dir"
  cd "$dir" || exit
  terraform init
  cd - > /dev/null || exit
}

# Function to plan Terraform
terraform_plan() {
  local dir=$1
  echo "Planning Terraform in directory: $dir"
  cd "$dir" || exit
  terraform plan -var-file="../terraform.tfvars"
  cd - > /dev/null || exit
}

# Function to apply Terraform
terraform_apply() {
  local dir=$1
  echo "Applying Terraform in directory: $dir"
  cd "$dir" || exit
  terraform apply -var-file="../terraform.tfvars" -auto-approve
  cd - > /dev/null || exit
}



# Initialize Terraform in all directories
terraform_init "ec2"
terraform_init "s3"
terraform_init "security_groups"

# Plan Terraform in all directories
terraform_plan "security_groups"
terraform_plan "s3"
terraform_plan "ec2"

# Apply Terraform in all directories
terraform_apply "security_groups"
terraform_apply "s3"
terraform_apply "ec2"



echo "All Terraform commands executed successfully."
