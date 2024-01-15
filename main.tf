terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4FYGP6IMHNPCXIOI"
secret_key = "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"
}

resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


variable "key_name" {}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

resource "local_file" "private_key" {
content= tls_private_key.rsa-4096.private_key_pem
filename = var.key_name
}


resource "aws_instance" "public_instance" {
 
   ami  =  "ami-03f4878755434977f"
  instance_type = "t3.micro"
  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "public_instance"
  }
}





