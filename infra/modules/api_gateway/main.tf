# Configuración del API Gateway para la API de la aplicación móvil de pedidos
# Superficie de práctica: completar con los recursos necesarios

# API Gateway REST API
resource "aws_api_gateway_rest_api" "pedidos_api" {
  name        = var.api_name
  description = "API para la aplicación móvil de pedidos"
  endpoint_configuration {
    types = [var.endpoint_type]
  }
}

# Recurso GET /pedidos
resource "aws_api_gateway_resource" "pedidos_resource" {
  rest_api_id = aws_api_gateway_rest_api.pedidos_api.id
  parent_id   = aws_api_gateway_rest_api.pedidos_api.root_resource_id
  path_part   = "pedidos"
}

# Método GET para obtener pedidos
resource "aws_api_gateway_method" "pedidos_get" {
  rest_api_id   = aws_api_gateway_rest_api.pedidos_api.id
  resource_id   = aws_api_gateway_resource.pedidos_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Método POST para crear pedidos
resource "aws_api_gateway_method" "pedidos_post" {
  rest_api_id   = aws_api_gateway_rest_api.pedidos_api.id
  resource_id   = aws_api_gateway_resource.pedidos_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integración con Lambda para GET
resource "aws_api_gateway_integration" "lambda_get" {
  rest_api_id = aws_api_gateway_rest_api.pedidos_api.id
  resource_id = aws_api_gateway_resource.pedidos_resource.id
  http_method = aws_api_gateway_method.pedidos_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_arn
}

# Integración con Lambda para POST
resource "aws_api_gateway_integration" "lambda_post" {
  rest_api_id = aws_api_gateway_rest_api.pedidos_api.id
  resource_id = aws_api_gateway_resource.pedidos_resource.id
  http_method = aws_api_gateway_method.pedidos_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_arn
}

# Deployment del API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.pedidos_api.id

  depends_on = [
    aws_api_gateway_integration.lambda_get,
    aws_api_gateway_integration.lambda_post
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Stage para el deployment
resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.pedidos_api.id
  stage_name    = var.stage_name
}