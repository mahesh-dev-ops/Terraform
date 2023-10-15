provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-southeast-1"
}
resource "aws_instance" "provisioner-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "remote-exec"
  }
  provisioner "local-exec" {
    command = "echo`curl ifconfig.me` > myip.txt"
  }

}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "ami" {
  type = string
}
