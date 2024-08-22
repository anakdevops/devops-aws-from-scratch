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



data "terraform_remote_state" "security_groups" {
  backend = "local"

  config = {
    path = "../security_groups/terraform.tfstate"
  }
}

resource "aws_instance" "ec2_anakdevops" {
  ami                    = "ami-060e277c0d4cce553"
  instance_type          = "t2.micro"
  key_name               = data.terraform_remote_state.security_groups.outputs.key_pair_id
  vpc_security_group_ids = [data.terraform_remote_state.security_groups.outputs.security_group_id]

  tags = {
    Name = "ec2_anakdevops"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y s3fs git docker.io
              sudo systemctl start docker
              echo "${var.access_key}:${var.secret_key}" > /etc/passwd-s3fs
              sudo chown root:root /etc/passwd-s3fs
              sudo chmod 600 /etc/passwd-s3fs
              sudo mkdir -p /mnt/s3-bucket
              echo "s3fs#${aws_s3_bucket.my_bucket.bucket} /mnt/s3-bucket fuse _netdev,allow_other 0 0" | sudo tee -a /etc/fstab
              sudo systemctl daemon-reload
              sudo mount -a
              sudo mkdir -p /usr/local/lib/docker/cli-plugins
              sudo curl -SL https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
              chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
              cd /mnt/s3-bucket
              EOF
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucketpython435we"
}
