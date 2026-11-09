# Configuracion de politicas de seguridad, roles IAM y permisos necesarios
# SUPERFICIE DE PRACTICA - El estudiante debe implementar la logica de seguridad

# Rol IAM para la Lambda que ejecuta la API
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Politica de permisos basicos para Lambda
resource "aws_iam_policy" "lambda_basic_execution" {
  name        = "lambda_basic_execution"
  description = "Politica de ejecucion basica para Lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Adjuntar politica al rol
resource "aws_iam_role_policy_attachment" "lambda_basic_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_basic_execution.arn
}

# Politica de acceso a DynamoDB para la tabla de pedidos
resource "aws_iam_policy" "dynamodb_access" {
  name        = "dynamodb_pedidos_access"
  description = "Permisos de acceso a la tabla de pedidos en DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:*:*:table/pedidos"
      }
    ]
  })
}

# Adjuntar politica de DynamoDB al rol
resource "aws_iam_role_policy_attachment" "dynamodb_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# Grupo de seguridad para API Gateway
resource "aws_security_group" "api_gateway_sg" {
  name        = "api_gateway_security_group"
  description = "Grupo de seguridad para API Gateway"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS inbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "api_gateway_sg"
    Environment = var.environment
  }
}

# Grupo de seguridad para Lambda
resource "aws_security_group" "lambda_sg" {
  name        = "lambda_security_group"
  description = "Grupo de seguridad para funciones Lambda"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.api_gateway_sg.id]
    description     = "Allow HTTPS from API Gateway"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS outbound"
  }

  tags = {
    Name        = "lambda_sg"
    Environment = var.environment
  }
}

# Grupo de seguridad para DynamoDB
resource "aws_security_group" "dynamodb_sg" {
  name        = "dynamodb_security_group"
  description = "Grupo de seguridad para DynamoDB"
  vpc_id      = var.vpc_id

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]
    description     = "Allow HTTPS to Lambda"
  }

  tags = {
    Name        = "dynamodb_sg"
    Environment = var.environment
  }
}