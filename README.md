# 💻Deploying-AWS-Infrastructure-with-Terraform☁️🟣

Hi! Welcome to my repository containing my AWS Project I've have undertaken as a Cloud enthusiast⚡️:

This project demonstrates how to deploy AWS Infrastructure using Terraform. Within the repository, you will see this README file for the project, high level architecture, scripting files and information on other key assets that I have used to develop this project as part of my portfolio.

## **Project Overview** 

As part of this project, I have used Terrafrom which is a IaC tool (Infrastructure as Code) to help deploy basic AWS infrastructure. Thr architecture consists of setting up a Virtual Private Cloud (VPC), Subnet, Security Group, and an EC2 instance in the "eu-west-2" region. This client project reveals practical, real-world example of Terraform in action from development to deployment. 

![AWS Terraform Infrasturcture High Level Diagram](https://github.com/user-attachments/assets/b3be7085-c3f2-4808-8784-4b5a844e168d)


- - - 
## **Architecture**
The resources used in this project include:

1. **Virtual Private Cloud (VPC):** Defines the network for your resources.
2. **Subnets: Segments the VPC:** into smaller IP address ranges.
3. **EC2 Instance:** Provides compute capacity in the cloud.
4. **Security Groups:** Controls inbound and outbound traffic to the EC2 instance.

## **Configuration Files**
This configuration files and commands can be located seperately as text files within this repository:

### providers.tf
```bash
1. provider "aws" {
  region = var.aws_region
}
```
### variables.tf
```bash
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
```
### main.tf
```bash
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
```
### outputs.tf
```bash
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.techone_vpc.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = aws_instance.example_instance.public_ip
}
```
### versions.tf
```bash
terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"

      version = "~> 3.0"
    }
  }
}
```
## **Deployment steps**
1. Initialize the Terraform Workspace using command:
```bash
   terraform init
```
Sets up the working directory and installs the necessary provider plugins.

2. Preview the Changes
```bash
   terraform plan
```
This command Displays the planned changes to ensure that the configuration meets expectations before applying. The planned changes would be confirmed on the VS Code Terminal and should look like this:

<img width="888" alt="Terraform Plan" src="https://github.com/user-attachments/assets/93610a37-2f16-4aae-a433-c832663d637e">



3. Apply the Configuration:
```bash
   terraform apply
```

This command Deploys the defined infrastructure to AWS as per the configuration files. and should look like this when you enter the command: 

<img width="875" alt="Resources Added via VS Code Terminal" src="https://github.com/user-attachments/assets/d268c1fb-8f29-4e65-94f4-e7cb3dc06a4e">

- - - 
4. AWS Console setup confirmation:
Atfer gaining confimration from your terminal that your resoutces have been set up, go the your AWS Console and head over to the reosurces that was set up as part of the Terraform script deployment. Here;s an example of the subnet group whcih was configured as part of the script deployment:
![example subnets created screenshot](https://github.com/user-attachments/assets/c20d0e0f-80ad-431b-9ae6-a2ab07d9ec56)

5. Destroy the Resources (when no longer needed)
```bash
   terraform destory
```

This command helps to clean up all deployed resources to avoid unnecessary costs.

## **How to Use**

1. Clone this repository to your local machine.
2. Follow the AWS documentation to create the required resources (S3 Bucket IAM Management) as outlined in the architecture overview
3. Use the provided scripts to set up the reosurce and applications
4. Configure the reosurces assets as per the architecture
5. Access the Website website through the endpoint URL for your bucket

## **Additional Resources**

- **AWS Documentation:** Refer to the [AWS documentation](https://aws.amazon.com/documentation/) for detailed guides on setting up S3 Bucket, IAM roles and other services such as VPC, EC2, Auto Scaling, and Load Balancers.
- **GitHub Repository Files:** Refer to [Otite-Git/Deploying-AWS-Infrastructure-with-Terraform](https://github.com/Otite-Git/Deploying-AWS-Infrastructure-with-Terraform/tree/main) to access the repository files for scripts, architectural diagrams, and configuration files necessary for deploying the website.

## **What problems did I solve by completing this project?**

1. **Simplicity:** I was able to effectively to simplift the creation of the hosting of the website through automating the deployment process using Terraform by reducing manual effort and ensures consistency across environments as the deployment of infrastructure and website hosting can be error-prone and time-consuming
   
2. **Infrastructure Management:** Managing infrastructure changes manually can lead to configuration drift and inconsistencies. Using Terraform allows for version-controlled infrastructure management and easy updates


## **What issues did I face while working on the project and how did I resolve that issue?**
  
- **Terraform Configuration Errors:** I had faced the issue of command errors and incorrect configuration in Terraform files. I was able to resolve both issues by using Terraform validate and terraform plan commands to check for errors and view changes before applying them

- **Terraform file setup Error:** Initially when starting the project, I had faced the challenge of my created main.tf file not being picked up or when entering the terraform apply command. I would get an error message stating the file could not be found in my directory despite it being there. I had resolved this issue by creating a new copy of the file and saving it in VS Code ensuring the Terraform logo appeared after it was correctly formatted. I then uploaded it into the directory folder and ran the Terrafrom apply command again. After doing this it had successfully worked
 

 ## **What overall lessons did I learn?**
 
- **Terraform Basics:** Infrastructure as Code (IaC): Understanding how to define and manage infrastructure using code. Terraform Configuration: Learning the commands and structure of Terraform configuration files (e.g., .tf files)

- **Terraform file configuration:** Infrastructure as Code (IaC): I learned the difference between resource and modules in Terraform and how providers act as the interface between Terraform and various cloud platforms and services. furthermore, I also learned that in Terraform, the state is like a snapshot that records the current state of your infrastructure managed by Terraform. This state file is essential because it allows Terraform to understand what your infrastructure looks like at any given time and helps it determine what changes need to be applied when you run your config.

- **Developing high level architectural diagrams:** I learned how to develop a high level architectural diagram using draw.io to help visuallly articulate the infrastructure setup and the architecural solutions required as part of this project.

