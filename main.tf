terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = "githubtoken" # or `GITHUB_TOKEN`
}

# Configure github repository

resource "github_repository" "example" {
  name        = "ssvkart-prod-repo"
  description = "my ssvkart prod repo"

  visibility = "public"
 
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "prod-vpc"
    Env = "prod"
  }
}

# Configure EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"

  tags = {
    Name = "prod-server"
  }
}

# Configure eip
resource "aws_eip" "prod-server-eip" {
  instance = aws_instance.web.id
  vpc      = true

  tags = {
    Name = "prod-server-eip"
  }
}
