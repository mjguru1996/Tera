resource "aws_instance" "ubuntu" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "terraform-instance"
  }
}
output "publicip" {
  value = aws_instance.ubuntu.public_ip
}
output "Instanceid" {
  value = aws_instance.ubuntu.instance_state
}