
# Create a VPC
resource "aws_vpc" "apsouth_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "test-apsouth_vpc"
    Environment = var.environment
  }
}

