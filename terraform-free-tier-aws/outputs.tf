output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.public.id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.linux.id
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.linux.private_ip
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.linux.public_ip
}

output "ssh_command" {
  description = "Command to connect to the EC2 instance over SSH"
  value       = "ssh -i ${local.private_key_path} ec2-user@${aws_instance.linux.public_ip}"
}
