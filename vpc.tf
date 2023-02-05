resource "aws_vpc" "Altschool_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Altschool_vpc"
  }
}

resource "aws_internet_gateway" "Altschool_internet_gateway" {
  vpc_id = aws_vpc.Altschool_vpc.id
  tags = {
    Name = "Altschool_internet_gateway"
  }
}

resource "aws_route_table" "Altschool-route-table-public" {
  vpc_id = aws_vpc.Altschool_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Altschool_internet_gateway.id
  }
  tags = {
    Name = "Altschool-route-table-public"
  }
}

resource "aws_subnet" "Altschool-public-subnet1" {
  vpc_id                  = aws_vpc.Altschool_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Altschool-public-subnet1"
  }
}

resource "aws_subnet" "Altschool-public-subnet2" {
  vpc_id                  = aws_vpc.Altschool_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Altschool-public-subnet2"
  }
}

resource "aws_route_table_association" "Altschool-public-subnet1-association" {
  subnet_id      = aws_subnet.Altschool-public-subnet1.id
  route_table_id = aws_route_table.Altschool-route-table-public.id
}

resource "aws_route_table_association" "Altschool-public-subnet2-association" {
  subnet_id      = aws_subnet.Altschool-public-subnet2.id
  route_table_id = aws_route_table.Altschool-route-table-public.id
}
