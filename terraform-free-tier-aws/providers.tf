provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Name        = "terraform-free-tier-lab"
      Environment = "learning"
      ManagedBy   = "Terraform"
    }
  }
}
