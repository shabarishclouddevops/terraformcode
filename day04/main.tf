terraform {

  backend "s3" {
    bucket       = "terraformbucket-ap-south-2-2026"
    key          = "test/terraform.tfstate"
    region       = "ap-south-2"
    use_lockfile = true
    encrypt      = true
    
  }

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
