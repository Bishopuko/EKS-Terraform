
resource "aws_vpc" "test" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = {
        "name" : "${var.name}-VPC"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.test.id
    cidr_block = cidrsubnet(var.cidr_block, var.subnet_cidr_bits, var.netnum)
    availability_zone = var.pub-avail
    tags = {
      "name" : "${var.name}-publicSN"
    }
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.test.id
    cidr_block = cidrsubnet(var.cidr_block, var.subnet_cidr_bits, var.netnumii)
    availability_zone = var.pri-avail
    tags = {
      "name" : "${var.name}-privateSN"
    }
}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.test.id
    tags = {
        "Name" : "${var.name}-IG"
  }

  depends_on = [aws_vpc.test]
}
resource "aws_route_table" "yes" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "access" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.yes.id
}

resource "aws_eip" "eip" {
    vpc = true
    tags = {
        "Name" : "${var.name}-ngw-ip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.name}-ngw"
  }
}

resource "aws_route" "main" {
  route_table_id = aws_route_table.yes.id
  nat_gateway_id = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/16"
}
