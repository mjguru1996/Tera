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
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terra-vpc"
    Managed_by = "terraform"
  }
}