# VPC and subnet definition
#
resource "aws_vpc" "GW-VPC" {
  //name                 = "GW VPC"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name    = "GW VPC"
    project = "GW"
    name    = "GW VPC"
  }
}

// Subnet1 definition
resource "aws_subnet" "GW-subnet1" {
  //name              = "GW Subnet1"
  vpc_id                  = aws_vpc.GW-VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "GW Subnet1"
    project = "GW"
    name    = "GW Subnet1"
  }

  depends_on = [aws_vpc.GW-VPC]
}

/*resource "aws_subnet" "GW-subnet2" {
  vpc_id     = aws_vpc.GW-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "GW subnet2"
    project = "GW"
    name    = "GW Subnet2"
  }

  depends_on = [aws_vpc.GW-VPC]
}*/

// Create Internet Gateway and Attach Internet Gateway to VPC
resource "aws_internet_gateway" "GW-IGW" {
  //name = "GW IGW"
  vpc_id = aws_vpc.GW-VPC.id

  tags = {
    Name    = "GW IGW"
    project = "GW"
    name    = "GW IGW"
  }
}

// Custom Route Table definition
resource "aws_route_table" "GW-RT" {
  //name   = "GW RT"
  vpc_id = aws_vpc.GW-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GW-IGW.id
  }

  tags = {
    Name    = "GW RT"
    project = "GW"
    name    = "GW RT"
  }
}

// Associate route table with subnet1
resource "aws_route_table_association" "GW-RT-association" {
  subnet_id      = aws_subnet.GW-subnet1.id
  route_table_id = aws_route_table.GW-RT.id
}
