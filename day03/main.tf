terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-2"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "terraformbucket-ap-south-2-2026"

  tags = {
    Name        = "testBucket"
    environment = "Test"
    
  }
}
