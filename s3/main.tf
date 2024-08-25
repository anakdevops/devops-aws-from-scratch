terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Define S3 bucket resource first
resource "aws_s3_bucket" "my_bucket" {
  bucket = "data-s3-anakdevops"
  force_destroy = true
}
