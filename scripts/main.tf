provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

resource "aws_security_group" "Primary" {
  name        = "Primary"
  description = "Allow inbound traffic on desired ports"

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32768
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 10000
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

# resource "null_resource" "generate_key_pair" {
#   provisioner "local-exec" {
#     command = "ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N ''"
#   }
# }

# Use the generated key pair in the AWS Key Pair resource
# resource "aws_key_pair" "eKart" {
#   key_name   = "eKart"
#   public_key = filebase64("C:/Users/pulip/Downloads/eKart.pub") # Specify the correct path to your public key file
# }

# # Write the private key to a local file
# resource "local_file" "private_key" {
#   content  = file("~/.ssh/id_rsa")
#   filename = "./private_key.pem"
# }

# # Write the public key to a local file
# resource "local_file" "public_key" {
#   content  = file("~/.ssh/id_rsa.pub")
#   filename = "./public_key.pub"
# }


resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-0c7217cdde317cfec" # Set your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "eKart"
  vpc_security_group_ids = [aws_security_group.Primary.id]


  tags = {
    Name = "micro-instance-${count.index + 1}"
  }
}

resource "aws_instance" "example1" {
  count         = 3
  ami           = "ami-0c7217cdde317cfec" # Set your desired AMI ID
  instance_type = "t2.medium"
  key_name      = "eKart"
  vpc_security_group_ids = [aws_security_group.Primary.id]


  tags = {
    Name = "medium-instance-${count.index + 1}"
  }
}


