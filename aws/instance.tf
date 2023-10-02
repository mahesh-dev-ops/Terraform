terraform {
  required_providers {
    aws = {
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWYWNTMV3NI5GIKES"
  secret_key = "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"
}


resource "aws_instance" "first-instance" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  key_name      = "terraform"
  tags = {
    Name        = "First-instance-from-tf"
    environment = "research and development"
    department  = "DevOPs"
  }
}

