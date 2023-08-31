provider "aws" {
  region     = "us-east-1"
}

data "aws_vpc" "selected" {
  id = "vpc-00e1890d94c4fcc63"
}

resource "aws_security_group" "docker-sg" {
  name   = "docker-sg"
  vpc_id = data.aws_vpc. selected.id

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "22"
    to_port     = "22"
  }


  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "8080"
    to_port     = "8080"
  }

    ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name = "docker-sg"
  }
}

resource "aws_instance" "docker-ec2" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  key_name      = "ryankey"

  vpc_security_group_ids = [aws_security_ group.docker-sg.id]

  tags = {
    Name = "docker-ec2"
  }
}