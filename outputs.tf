output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.techone_vpc.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = aws_instance.example_instance.public_ip
}
