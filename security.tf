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






