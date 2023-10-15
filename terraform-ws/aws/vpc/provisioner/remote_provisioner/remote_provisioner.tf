provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-southeast-1"
}
resource "aws_instance" "provisioner-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "terra"
  tags = {
    Name = "remote-exec"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/terra.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "curl ifconfig.me",
      "whoami",
    ]
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

