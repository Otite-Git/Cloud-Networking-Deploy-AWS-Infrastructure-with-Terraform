variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "The instance type of the EC2 instance."
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
}
