# outputs.tf - Definición de outputs para exponer información relevante de la infraestructura desplegada
# SUPERFICIE DE PRACTICA: completar con los outputs necesarios para la API de pedidos

output "api_gateway_endpoint" {
  description = "Endpoint público de la API Gateway para la aplicación de pedidos"
  value       = aws_api_gateway_deployment.pedidos_api.invoke_url
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución de la API Gateway"
  value       = aws_api_gateway_deployment.pedidos_api.execution_arn
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda que procesa los pedidos"
  value       = aws_lambda_function.pedidos_lambda.arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.pedidos_lambda.function_name
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB donde se almacenan los pedidos"
  value       = aws_dynamodb_table.pedidos_table.name
}

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.pedidos_table.arn
}

output "lambda_role_arn" {
  description = "ARN del rol de IAM asociado a la función Lambda"
  value       = aws_iam_role.lambda_role.arn
}

output "api_gateway_rest_api_id" {
  description = "ID de la API Gateway REST"
  value       = aws_api_gateway_rest_api.pedidos_api.id
}