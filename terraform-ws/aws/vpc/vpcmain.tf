provider "aws" {
  access_key = "AKIAQQOCFA34XQSDXNX2"
  secret_key = "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"
  region     = "ap-south-1"
}
resource "aws_vpc" "kia_vpc" {
  cidr_block       = "30.30.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "kia-vpc"
  }
}
resource "aws_subnet" "kia_subnet" {
  vpc_id            = aws_vpc.kia_vpc.id
  cidr_block        = "30.30.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "kia-subnet"
  }
}
resource "aws_internet_gateway" "kia_igw" {
  vpc_id = aws_vpc.kia_vpc.id
  tags = {
    Name = "kia-igw"
  }
}
resource "aws_route_table" "kia_route_table" {
  vpc_id = aws_vpc.kia_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kia_igw.id
  }
  tags = {
    Name = "kia-route-table"
  }

}

resource "aws_route_table_association" "kia_route_table_association" {
  subnet_id      = aws_subnet.kia_subnet.id
  route_table_id = aws_route_table.kia_route_table.id
}

resource "aws_instance" "kia_instance" {
  ami                         = "ami-08e5424edfe926b43"
  subnet_id                   = aws_subnet.kia_subnet.id
  count                       = 1
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  key_name                    = "terraform"
  availability_zone           = "ap-south-1a"
  tags = {
    Name = "kia-instance"
  }
}






















