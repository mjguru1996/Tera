provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "Test-1" {
  name = "Guru"
  path = "/"
}
resource "aws_iam_user" "Test-2" {
  name = "Prasad"
  path = "/"
}
resource "aws_instance" "ubuntu" {
  ami = "ami-019715e0d74f695be"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-instance"
  }
}
