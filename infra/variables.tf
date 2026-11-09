# Definición de variables para parametrizar la configuración de la infraestructura.
# Estas variables permiten personalizar el despliegue según el entorno y requisitos.

variable "aws_region" {
  description = "Región de AWS donde se aprovisionarán los recursos."
  type        = string
  default     = "us-east-1"
}

variable "secondary_aws_region" {
  description = "Región secundaria de AWS para recursos multi-región."
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Entorno de despliegue (ej: dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado y nombramiento de recursos."
  type        = string
  default     = "api-pedidos"
}

variable "api_gateway_name" {
  description = "Nombre del API Gateway para la aplicación de pedidos."
  type        = string
  default     = "api-pedidos-gateway"
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda que procesa los pedidos."
  type        = string
  default     = "process-pedidos"
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para almacenar los pedidos."
  type        = string
  default     = "pedidos-table"
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage del API Gateway (ej: v1, prod)."
  type        = string
  default     = "v1"
}

variable "tags" {
  description = "Tags adicionales para los recursos."
  type        = map(string)
  default     = {}
}

# Variables para configuración de seguridad
variable "enable_api_gateway_logging" {
  description = "Habilita el logging de acceso para API Gateway."
  type        = bool
  default     = true
}

variable "api_gateway_log_retention_days" {
  description = "Días de retención para los logs de API Gateway."
  type        = number
  default     = 7
}

# Variables para configuración de red
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "IDs de las subnets donde se desplegarán los recursos."
  type        = list(string)
  default     = []
}

# Variables para configuración de dominios y certificados
variable "domain_name" {
  description = "Nombre de dominio para la API (ej: api.pedidos.com)."
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para HTTPS."
  type        = string
  default     = ""
}

# Variables para configuración de autenticación
variable "cognito_user_pool_arn" {
  description = "ARN del User Pool de Cognito para autenticación."
  type        = string
  default     = ""
}

# Variables para configuración de monitoreo
variable "enable_cloudwatch_alarms" {
  description = "Habilita alarmas de CloudWatch para monitoreo."
  type        = bool
  default     = false
}

variable "alarm_email" {
  description = "Correo electrónico para notificaciones de alarmas."
  type        = string
  default     = ""
}