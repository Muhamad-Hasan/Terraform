terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.35.0"
    }
  }
}

provider "aws" {
  # Configuration options
  access_key = "AKIAR73HC2JIQPIQKJPS"
  secret_key = "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"
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  subnet_id = "subnet-0f5d9e944e4e21bdf"
  key_name = "ecommerce-Virgania"
  security_groups = [ "sg-0bc4f0347e280573e" ]
  user_data = <<EOF
		#! /bin/bash
    sudo yum update
		sudo yum install -y httpd
		sudo systemctl start httpd.service
    echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF 

  tags = {
    Name = "HelloWorld"
  }
}