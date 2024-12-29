locals {
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main-vlad"
  }
}

resource "aws_subnet" "public" {
 
 count = length(var.public_cidr)
 
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "public ${count.index + 1}"
  }
}



resource "aws_subnet" "private" {

  count = length(var.private_cidr)
  
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "private ${count.index + 1}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public" {
 
 count = length(var.public_cidr)
 
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  
  count = length(var.public_cidr)
  
  vpc = true
  
  
  tags = {
    Name = "nat-main ${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat-main" {
 
 count = length(var.public_cidr)
 
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-main ${count.index + 1}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}


resource "aws_route_table" "private" {
  
  count = length(var.private_cidr)
  
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-main[count.index].id
  }

  tags = {
    Name = "private ${count.index + 1}"
  }
}


resource "aws_route_table_association" "private" {
  
  count = length(var.private_cidr)
  
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}


