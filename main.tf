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

# Adding Security groups
/*

resource "aws_security_group" "tf_sg" {
  name        = "Security group using Terraform"
  description = "Security group using Terraform"
  vpc_id      = "vpc-0d2736453cc26440f"


 ingress {
    description	     = "HTTP"
    from_port        = 1000
    to_port          = 1000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

ingress {
    description	     = "SSH"
    from_port        = 2000
    to_port          = 2000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "tf_sg"
  }
}

*/




