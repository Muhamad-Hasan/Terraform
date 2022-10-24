#Create the VPC
resource "aws_vpc" "Main" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"
}

# creat public Subnet 1
resource "aws_subnet" "publicSubnetOne" {
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = var.publicSubnetOne
  map_public_ip_on_launch = true

}


# creat public Subnet 2
resource "aws_subnet" "publicSubnetTwo" {
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = var.publicSubnetTwo
  map_public_ip_on_launch = true

}


#Create a Private Subnet                   
resource "aws_subnet" "privatesubnetOne" {
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = var.privateSubnetOne
  map_public_ip_on_launch = true

}


#Create a Private Subnet 2                 
resource "aws_subnet" "privatesubnetTwo" {
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = var.privateSubnetTwo
  map_public_ip_on_launch = true

}

# Creating Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Main.id
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
}

#Route table Association with Public Subnet's
resource "aws_route_table_association" "PublicRTassociationOne" {
  subnet_id      = aws_subnet.publicSubnetOne.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTassociationTwo" {
  subnet_id      = aws_subnet.publicSubnetTwo.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.Main.cidr_block]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.Main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#create Ec2 instance 1
resource "aws_instance" "web1" {
  ami             = var.instanceAMi
  instance_type   = var.instanceType
  subnet_id       = aws_subnet.publicSubnetOne.id
  key_name        = var.instanceKeyName
  security_groups = [aws_security_group.allow_tls.id]
  user_data       = <<EOF
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

#create Ec2 instance 2
resource "aws_instance" "web2" {
  ami             = var.instanceAMi
  instance_type   = var.instanceType
  subnet_id       = aws_subnet.publicSubnetTwo.id
  key_name        = var.instanceKeyName
  security_groups = [aws_security_group.allow_tls.id]
  user_data       = <<EOF
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

