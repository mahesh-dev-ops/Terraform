provider "aws" {
  access_key = "AKIAWYWNTMV3GCBOGZWE"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_instance" "resource_one" {
  ami           = "ami-002843b0a9e09324a"
  instance_type = "t2.micro"
  count         = length(var.my_list)
  tags = {
    Name = "server-${count.index}"
  }
}
variable "my_list" {
  default = ["zero", "one", "two"]
}
