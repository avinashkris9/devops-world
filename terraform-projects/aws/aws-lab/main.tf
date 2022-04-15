resource "aws_vpc" "main_lab" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC-Lab"

  }
}


resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main_lab.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = var.az[0]
  map_public_ip_on_launch=true
  tags = {
    Name = "Public subnet A"

  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main_lab.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = var.az[1]
  map_public_ip_on_launch=true
  tags = {
    Name = "Public subnet B"

  }
}
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main_lab.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = var.az[0]

  tags = {
    Name = "Private subnet B"

  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main_lab.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = var.az[0]

  tags = {
    Name   = "Private subnet A"
    source = "aws-lab"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_lab.id

  tags = {
    Name   = "main"
    source = "aws-lab"
  }
}

# resource "aws_internet_gateway_attachment" "main_igw_route" {
#   internet_gateway_id = aws_internet_gateway.gw.id
#   vpc_id              = aws_vpc.main.id
# }


resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "public_route"

  }
}

resource "aws_route_table_association" "attach_public_route" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "attach_public_route_b" {
  subnet_id      =aws_subnet.public_b.id
  route_table_id = aws_route_table.public_route.id
}


