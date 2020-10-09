provider "aws" {
  region = "eu-central-1"
}

variable "keypair_name" {
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*"]
  }
}

resource "aws_security_group" "default" {
  name = "terraform-example"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon-linux-2.id
  key_name        = var.keypair_name
  security_groups = [aws_security_group.default.name]
}

output "public_ip" {
  value = "Connect via ${aws_instance.web.public_ip}"
}

