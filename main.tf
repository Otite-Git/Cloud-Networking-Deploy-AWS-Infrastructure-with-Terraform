resource "aws_vpc" "techone_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "techone_vpc"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.techone_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "example-subnet"
  }
}

resource "aws_security_group" "techonetwenty_sg" {
  name        = "techonetwenty-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.techone_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "techonetwenty_sg"
  }
}

resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.techonetwenty_sg.id]

  tags = {
    Name = "example-instance"
  }
}
