resource "aws_vpc" "devops" {
  cidr_block = "172.25.0.0/16"

  tags = {
    Name = "devops"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.available_zones.names)
  vpc_id                  = aws_vpc.devops.id
  cidr_block              = cidrsubnet(cidrsubnet(aws_vpc.devops.cidr_block, 2, 2), 6, count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Public = "true"
  }
}

resource "aws_subnet" "private" {
  count             = length(data.aws_availability_zones.available_zones.names)
  vpc_id            = aws_vpc.devops.id
  cidr_block        = cidrsubnet(aws_vpc.devops.cidr_block, 6, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}