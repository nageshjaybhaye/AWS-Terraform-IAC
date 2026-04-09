resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK14+A1zukKmHy3lKjjRPJisfBBa30ixVVSPDyw5o64e hp@DESKTOP-89M9JM8"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "allow_tls"
  }
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "my_instance" {
  count             = var.server_count
  ami               = var.ami_id
  instance_type     = var.instace_type
  key_name          = aws_key_pair.deployer.key_name
  security_groups   = [aws_security_group.my-sg.name]
  user_data         = file("user_data.sh")
  tags = {
    Name = "Terraform-server-Nginx"
  }
  root_block_device {
        volume_size = 15
        volume_type = "gp3"
  }
}
