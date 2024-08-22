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


# Retrieve security group IDs
data "terraform_remote_state" "security_groups" {
  backend = "local"

  config = {
    path = "../security_groups/terraform.tfstate"
  }
}

# Retrieve security group IDs
data "terraform_remote_state" "my_bucket" {
  backend = "local"

  config = {
    path = "../s3/terraform.tfstate"
  }
}

# EC2 instances
resource "aws_instance" "ec2_anakdevops" {
  count                  = 3
  ami                    = "ami-060e277c0d4cce553"
  instance_type          = "t2.micro"
  key_name               = data.terraform_remote_state.security_groups.outputs.key_pair_id
  vpc_security_group_ids = [data.terraform_remote_state.security_groups.outputs.security_group_id]
  

  provisioner "file" {
    source      = "../security_groups/keypair_anakdevops.pem"
    destination = "/tmp/keypair_anakdevops.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../security_groups/keypair_anakdevops.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "ec2_anakdevops-${count.index}"
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
              echo "s3fs#${data.terraform_remote_state.my_bucket.outputs.bucket_name} /mnt/s3-bucket fuse _netdev,allow_other 0 0" | sudo tee -a /etc/fstab
              sudo systemctl daemon-reload
              sudo mount -a
              sudo mkdir -p /usr/local/lib/docker/cli-plugins
              sudo curl -SL https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
              chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
              mkdir -p ~/.ssh
              echo "${data.terraform_remote_state.security_groups.outputs.key_public_key}" >> ~/.ssh/authorized_keys
              chmod 600 ~/.ssh/authorized_keys
              EOF
}




