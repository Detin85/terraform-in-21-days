resource "aws_instance" "app_server" {
  ami           = "ami-0e54671bdf3c8ed8d"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}