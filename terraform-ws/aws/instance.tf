terraform {
  required_providers {
    aws = {
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA43BU4TPQO4MMMPMP"
  secret_key = "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"
}


resource "aws_instance" "first-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "terraform"
  count         = "3"
  tags = {
    Name        = "First-instance-from-tf"
    environment = "research and development"
    department  = "DevOPs"
  }
}

variable "ami" {
  default = "  "
}

variable "instance_type" {
  default = "  "
}
