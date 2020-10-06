provider "aws" {
  region = "eu-central-1"
}

variable "keypair_name" {
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon-linux-2.id
  key_name        = var.keypair_name
}

