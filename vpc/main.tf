# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.project}-vpc"
  }
}

# Prod Subnet
# Prod public subnet 생성 (ap-northeast-2a)
resource "aws_subnet" "prod_public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prod_public_subnet1_cidr_block
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "${var.project}-prod-subnet-public1"
  }
}

# Prod public subnet 생성 (ap-northeast-2b)
resource "aws_subnet" "prod_public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prod_public_subnet2_cidr_block
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "${var.project}-prod-subnet-public2"
  }
}

# Prod private subnet 생성 (ap-northeast-2a)
resource "aws_subnet" "prod_private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prod_private_subnet1_cidr_block
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "${var.project}-prod-subnet-private1"
  }
}

# Prod private subnet 생성 (ap-northeast-2b)
resource "aws_subnet" "prod_private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prod_private_subnet2_cidr_block
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "${var.project}-prod-subnet-private2"
  }
}

# Stage Subnet
# Stage public subnet 생성 (ap-northeast-2c)
resource "aws_subnet" "stage_public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.stage_public_subnet_cidr_block
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "${var.project}-stage-subnet"
  }
}

# Internet Gateway 생성
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-igw"
  }
}

# NAT Gateway
# Public IP 생성
resource "aws_eip" "nat_gateway" {
  lifecycle {
    create_before_destroy = true
  }
}

# NAT Gateway 생성 (시간당 USD 0.059)
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.prod_public_subnet1.id
  tags = {
    Name = "${var.project}-nat-gateway"
  }
}

# Route Table
# Public Subnet Route Table 생성
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # Internet Gateway 연결
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project}-public-route-table"
  }
}

# Private Subnet Route Table 생성
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # NAT Gateway 연결
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.project}-private-route-table"
  }
}

# S3 Endpoint 생성
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
  tags = {
    Name = "${var.project}-s3-endpoint"
  }
}

# S3 Endpoint Route Table 연결
resource "aws_vpc_endpoint_route_table_association" "s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.private.id
}

# Route Table 연결
# Public Subnet Route Table 연결
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.prod_public_subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.prod_public_subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "stage" {
  subnet_id      = aws_subnet.stage_public_subnet1.id
  route_table_id = aws_route_table.public.id
}

# Private Subnet Route Table 연결
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.prod_private_subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.prod_private_subnet2.id
  route_table_id = aws_route_table.private.id
}
