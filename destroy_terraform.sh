#!/bin/bash

# Function to destroy Terraform
terraform_destroy() {
  local dir=$1
  echo "Destroying Terraform in directory: $dir"
  cd "$dir" || exit
  terraform destroy -var-file="../terraform.tfvars" -auto-approve
  cd - > /dev/null || exit
}


# Destroy Terraform in all directories
terraform_destroy "ec2-rancher"
terraform_destroy "ec2-cicd"
terraform_destroy "s3"
terraform_destroy "security_groups"

echo "All Terraform commands executed successfully."
