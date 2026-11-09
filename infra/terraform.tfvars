# terraform.tfvars - Valores de las variables para el entorno específico
# Estos valores se aplican al proyecto completo salvo que se sobrescriban por ambiente

# Configuración general del proyecto
project_name = "pedidos-app"
environment  = "shared"
aws_region   = "us-east-1"

# Configuración de la API Gateway
gateway_stage_name = "prod"
gateway_timeout_seconds = 30
gateway_throttling_burst_limit = 500
gateway_throttling_rate_limit = 1000

# Configuración de la tabla DynamoDB
dynamodb_table_name         = "pedidos"
dynamodb_partition_key     = "pedido_id"
dynamodb_sort_key          = "usuario_id"
dynamodb_billing_mode      = "PAY_PER_REQUEST"
dynamodb_point_in_time_recovery = true

# Configuración de la función Lambda
lambda_function_name      = "pedidos-processor"
lambda_runtime            = "python3.11"
lambda_timeout            = 30
lambda_memory_size        = 256
lambda_ephemeral_storage  = 512

# Configuración de seguridad
enable_dynamodb_server_side_encryption = true
enable_api_gateway_cloudwatch_logs     = true
lambda_cloudwatch_log_retention_days   = 30

# Configuración de red (VPC)
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de tags
owner_team     = "plataforma"
project_cost_center = "fintech-pedidos"