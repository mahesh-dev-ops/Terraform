provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-southeast-1"
}
resource "aws_vpc" "bajaj_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "Bajaj-vpc"
  }
}
resource "aws_subnet" "bajaj_subnet" {
  vpc_id            = aws_vpc.bajaj_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "Bajaj-subnet"
  }
}
resource "aws_internet_gateway" "bajaj_igw" {
  vpc_id = aws_vpc.bajaj_vpc.id
  tags = {
    Name = "Bajaj-IGW"
  }
}
resource "aws_route_table" "bajaj_rt" {
  vpc_id = aws_vpc.bajaj_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bajaj_igw.id
  }
  tags = {
    Name = "Bajaj-RT"
  }
}
resource "aws_route_table_association" "bajaj_rta" {
  subnet_id      = aws_subnet.bajaj_subnet.id
  route_table_id = aws_route_table.bajaj_rt.id
}
resource "aws_instance" "bajaj_instance" {
  ami                         = var.ami
  subnet_id                   = aws_subnet.bajaj_subnet.id
  count                       = var.no_of_instance
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  key_name                    = "terra"
  availability_zone           = "ap-southeast-1a"
  tags = {
    Name = "Bajaj-instance"
  }
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.10.0.0/16"
}
variable "subnet_cidr_block" {
  type    = string
  default = "10.10.0.0/24"
}
variable "ami" {
  type = string
}
variable "no_of_instance" {
  type = string
}
output "vpc_id"{
	value = aws_vpc.bajaj_vpc.id
}
output "subnet_id" {
	value = aws_subnet.bajaj_subnet.id
}
data "aws_instance" "terra-ws" {
	instance_id = "i-04ae0258c0b03f185"
}
output "public_ip_terra-ws" {
	value = data.aws_instance.terra-ws.public_ip
}
