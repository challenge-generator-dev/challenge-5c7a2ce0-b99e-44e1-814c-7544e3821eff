# environments/dev/terraform.tfvars - Variables específicas del entorno de desarrollo
# Sobrescribe los valores de terraform.tfvars para el ambiente dev

# Configuración general del proyecto - entorno desarrollo
project_name = "pedidos-app"
environment  = "dev"
aws_region   = "us-east-1"

# Configuración de la API Gateway - desarrollo
gateway_stage_name = "dev"
gateway_timeout_seconds = 60
gateway_throttling_burst_limit = 100
gateway_throttling_rate_limit = 200

# Configuración de la tabla DynamoDB - desarrollo
dynamodb_table_name         = "pedidos-dev"
dynamodb_partition_key     = "pedido_id"
dynamodb_sort_key          = "usuario_id"
dynamodb_billing_mode      = "PAY_PER_REQUEST"
dynamodb_point_in_time_recovery = false

# Configuración de la función Lambda - desarrollo
lambda_function_name      = "pedidos-processor-dev"
lambda_runtime            = "python3.11"
lambda_timeout            = 60
lambda_memory_size        = 128
lambda_ephemeral_storage  = 256

# Configuración de seguridad - desarrollo (menos restrictivo)
enable_dynamodb_server_side_encryption = true
enable_api_gateway_cloudwatch_logs     = true
lambda_cloudwatch_log_retention_days   = 7

# Configuración de red - desarrollo
vpc_cidr_block           = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de tags - desarrollo
owner_team     = "plataforma-dev"
project_cost_center = "fintech-pedidos-dev"