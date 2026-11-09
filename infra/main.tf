# Configuración principal de Terraform para la API de Pedidos
# Este archivo define los recursos de infraestructura global

terraform {
  # Backend configuration for state management
  backend "s3" {
    bucket = "terraform-state-pedidos"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}

# Provider configuration
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "app-pedidos"
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "equipo-infraestructura"
    }
  }
}

# Módulo de networking
module "networking" {
  source = "./modules/networking"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

# Módulo de DynamoDB
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = var.table_name
  environment = var.environment
}

# Módulo de Lambda
module "lambda" {
  source = "./modules/lambda"

  environment      = var.environment
  lambda_runtime   = var.lambda_runtime
  dynamodb_table_arn = module.dynamodb.table_arn
}

# Módulo de API Gateway
module "api_gateway" {
  source = "./modules/api_gateway"

  environment          = var.environment
  api_id               = var.api_id
  lambda_function_arn  = module.lambda.function_arn
}

# Módulo de seguridad
module "security" {
  source = "./modules/security"

  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  lambda_sg_id      = module.lambda.security_group_id
  api_gateway_sg_id = module.api_gateway.security_group_id
}