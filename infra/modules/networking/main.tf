# Configuracion de redes, VPC y subredes para la infraestructura
# SUPERFICIE DE PRACTICA - El estudiante debe implementar la configuracion de red

# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "pedidos_app_vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "pedidos_app_igw"
    Environment = var.environment
  }
}

# Tabla de rutas principal
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "pedidos_app_route_table"
    Environment = var.environment
  }
}

# Subred publica 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos_public_subnet_1"
    Environment = var.environment
  }
}

# Subred publica 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos_public_subnet_2"
    Environment = var.environment
  }
}

# Subred privada 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name        = "pedidos_private_subnet_1"
    Environment = var.environment
  }
}

# Subred privada 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name        = "pedidos_private_subnet_2"
    Environment = var.environment
  }
}

# Asociar subredes publicas a la tabla de rutas
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.main.id
}

# Tabla de rutas para subredes privadas (NAT Gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "pedidos_private_route_table"
    Environment = var.environment
  }
}

# Asociar subredes privadas a la tabla de rutas privada
resource "aws_route_table_association" "private_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "pedidos_nat_eip"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name        = "pedidos_nat_gateway"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]
}

# Ruta desde subredes privadas a NAT Gateway
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}