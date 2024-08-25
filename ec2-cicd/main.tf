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
resource "aws_instance" "ec2_anakdevops_cicd" {
  count                  = 1
  ami                    = "ami-0497a974f8d5dcef8" #22.04.4 LTS (Jammy Jellyfish)
  instance_type          = "t2.xlarge"
  key_name               = data.terraform_remote_state.security_groups.outputs.key_pair_id
  vpc_security_group_ids = [data.terraform_remote_state.security_groups.outputs.security_group_id]
  
    root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

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

    provisioner "file" {
    source      = "install.yaml"
    destination = "/tmp/install.yaml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../security_groups/keypair_anakdevops.pem")
      host        = self.public_ip
    }
  }

    provisioner "file" {
    source      = "docker-compose.yml"
    destination = "/tmp/docker-compose.yml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../security_groups/keypair_anakdevops.pem")
      host        = self.public_ip
    }
  }

    provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/nginx.conf"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../security_groups/keypair_anakdevops.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "ec2_anakdevops_cicd-${count.index}"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y s3fs curl git ansible
              echo "${var.access_key}:${var.secret_key}" > /etc/passwd-s3fs
              sudo chown root:root /etc/passwd-s3fs
              sudo chmod 600 /etc/passwd-s3fs
              sudo mkdir -p /mnt/s3-bucket
              echo "s3fs#${data.terraform_remote_state.my_bucket.outputs.bucket_name} /mnt/s3-bucket fuse _netdev,allow_other 0 0" | sudo tee -a /etc/fstab
              sudo systemctl daemon-reload
              sudo mount -a
              mkdir -p ~/.ssh
              echo "${data.terraform_remote_state.security_groups.outputs.key_public_key}" >> ~/.ssh/authorized_keys
              chmod 600 ~/.ssh/authorized_keys
              sudo ansible-playbook /tmp/install.yaml
              sudo mkdir -p /mnt/s3-bucket/data-jenkins
              sudo chmod 777 -R /mnt/s3-bucket/data-jenkins
              cd /tmp
              docker compose up -d
              EOF
}




