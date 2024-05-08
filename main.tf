terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = "ap-southeast-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# resource "aws_instance" "test_instance" {
#   ami           = "ami-003c463c8207b4dfa"
#   instance_type = "t2.medium"
#   tags = {
#     Name = "kafka-playground"
#   }
# }
resource "aws_vpc" "main" {
  cidr_block       = "238.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "kafka-playground"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "238.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "kafka-playground"
  }
}

resource "aws_subnet" "main_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "238.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "kafka-playground"
  }
}
