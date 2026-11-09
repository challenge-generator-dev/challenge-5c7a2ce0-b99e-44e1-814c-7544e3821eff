# Configuración de las funciones Lambda para la lógica de la API de pedidos
# Superficie de práctica: completar con el código de las funciones

# Rol de ejecución para Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = var.lambda_role_name

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

# Política de permisos para Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Política de acceso a DynamoDB
resource "aws_iam_policy" "dynamodb_access" {
  name = "lambda-dynamodb-access"

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
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# Función Lambda para manejar pedidos
resource "aws_lambda_function" "pedidos_function" {
  filename         = var.lambda_zip_path
  function_name    = var.lambda_function_name
  role            = aws_iam_role.lambda_exec_role.arn
  handler         = var.lambda_handler
  source_code_hash = filebase64sha256(var.lambda_zip_path)
  runtime         = var.lambda_runtime
  timeout         = var.lambda_timeout
  memory_size     = var.lambda_memory_size

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
      REGION        = var.aws_region
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_iam_role_policy_attachment.lambda_dynamodb_access
  ]
}

# Permiso para que API Gateway invoque Lambda
resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pedidos_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}