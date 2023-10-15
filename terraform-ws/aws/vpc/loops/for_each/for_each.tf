provider "aws" {
  access_key = "AKIAWYWNTMV3GCBOGZWE"
  secret_key = "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"
  region     = "ap-southeast-1"
}
resource "aws_instance" "resource_one" {
  ami           = "ami-002843b0a9e09324a"
  instance_type = "t2.micro"
  for_each      = toset(["MI", "LG", "SONY"])
  tags = {
    Name = each.key
  }
}
