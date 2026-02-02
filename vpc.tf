# 1. VPC
# 2. IG
# 3. Public Subnet
# 4. Private Subnet
# 5. Private RT
# 6. Public RT 
# 7. Public Subnet Association
# 8. Private Subnet Association
# 9. NAT Gateway
# 10. SG 1- 
# 11. EC2 -Public 
# 12. Private Subnet
resource "aws_vpc" "vz" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "verizon-vpc"
    Managed_by = "terraform"
  }
}
resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.vz.id

  tags = {
    Name = "VZInternetgateway"
    Managed_by = "terraform"
  }
}
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.vz.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "publicsubnet"
  }
}
resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.vz.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "privatesubnet"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vz.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.ig1.id
  }

  tags = {
    Name = "public_route_table"
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vz.id

  tags = {
    Name = "private_route_table"
  }
}
resource "aws_route_table_association" "publicsub_rt_a" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "privatesub_rt_a" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_security_group" "sg1" {
  name        = "sg1"
  vpc_id      = aws_vpc.vz.id

 ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg1"
  }
}

resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id = aws_subnet.publicsubnet.id
  key_name = "ubuntu"
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  
  tags = {
    Name = "webserver"
  }
}
resource "aws_instance" "dbserver" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id = aws_subnet.privatesubnet.id
  key_name = "ubuntu"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  
  tags = {
    Name = "webserver"
  }
}
output "publicip" {
   value = aws_instance.webserver.id
   
}
output "privateip" {
value = aws_instance.dbserver.id
}


