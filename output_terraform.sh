#!/bin/bash

# Function to initialize Terraform
terraform_init() {
  local dir=$1
  echo "Initializing Terraform in directory: $dir"
  cd "$dir" || exit
  terraform output
  cd - > /dev/null || exit
}


# Initialize Terraform in all directories
terraform_init "ec2-rancher"
terraform_init "ec2-cicd"
terraform_init "s3"
terraform_init "security_groups"


echo "All Terraform commands executed successfully."
