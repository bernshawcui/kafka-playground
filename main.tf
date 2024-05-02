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

resource "aws_instance" "test_instance" {
  ami           = "ami-0f74c08b8b5effa56"
  instance_type = "t2.nano"
  tags = {
    Name = "test_instance"
  }
}
