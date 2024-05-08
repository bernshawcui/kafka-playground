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
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "kafka-playground"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "kafka-playground"
  }
}


resource "aws_route_table" "example" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "kafka-playground"
  }
}


resource "aws_subnet" "subnet_ap_southeast_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "kafka-playground"
  }
}

resource "aws_subnet" "subnet_ap_southeast_1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "kafka-playground"
  }
}

resource "aws_subnet" "subnet_ap_southeast_1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "kafka-playground"
  }
}
