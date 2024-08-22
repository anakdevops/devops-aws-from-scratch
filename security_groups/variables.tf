variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "keypair_anakdevops.pem"
}

variable "region" {
  description = "AWS region"
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}
