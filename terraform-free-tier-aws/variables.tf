variable "aws_region" {
  description = "AWS region to deploy the infrastructure into."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type. Default is Free Tier-eligible in many regions (t2.micro). If unsupported, set to another eligible option such as t3.micro."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair to create in AWS."
  type        = string
  default     = "terraform-free-tier-key"
}

variable "public_key_path" {
  description = "Path to the local public SSH key to upload to AWS, for example ~/.ssh/id_rsa.pub"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_allowed_cidr" {
  description = "CIDR range allowed for SSH. Replace YOUR_PUBLIC_IP with your public IPv4 address, for example 203.0.113.10/32."
  type        = string
  default     = "YOUR_PUBLIC_IP/32"
}
