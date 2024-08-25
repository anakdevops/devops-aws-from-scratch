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

# Define S3 bucket object resource for uploading a file
resource "aws_s3_object" "example_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "nginx.conf"  # Name of the file in S3
  source = "nginx.conf"  # Path to your local file
  acl    = "private"
}

resource "aws_s3_object" "example_file1" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "dashboard_rancher.sh"  # Name of the file in S3
  source = "dashboard_rancher.sh"  # Path to your local file
  acl    = "private"
}

