resource "aws_instance" "public" {
  ami                         = "ami-0ecf75a98fe8519d7"
  associate_public_ip_address = true
  instance_type               = "t3.nano"
  key_name                    = "main"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.public[0].id

  tags = {
    Name = "$(var.env_code)-public"
  }
}

resource "aws_security_group" "public" {
  name        = "$(var.env_code)-public"
  description = "Allow inbound traffic"
  vpc_id         = aws_vpc.main.id

  ingress {
    description = "SSH from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["81.26.206.228/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "$(var.env_code)-public"
  }
}