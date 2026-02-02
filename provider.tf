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
