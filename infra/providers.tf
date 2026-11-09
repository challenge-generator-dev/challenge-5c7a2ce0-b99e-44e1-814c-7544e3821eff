# Configuración de providers para Terraform
# Este archivo define los proveedores necesarios para aprovisionar la infraestructura
y sus versiones específicas para garantizar compatibilidad y estabilidad.

terraform {
  required_version = "~> 1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

# Provider de AWS configurado para la región por defecto.
# La región puede ser sobrescrita mediante variables.
provider "aws" {
  region = var.aws_region
  
  # Configuración de tags por defecto para todos los recursos
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración adicional para habilitar características específicas de AWS
# como el uso de endpoints privados o configuraciones avanzadas de red.
provider "aws" {
  alias  = "secondary"
  region = var.secondary_aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración para el backend de Terraform (ejemplo: S3 + DynamoDB)
# Este bloque se descomenta cuando se configura el backend remoto.
# terraform {
#   backend "s3" {
#     bucket         = "tf-state-bucket"
#     key            = "api-pedidos/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "tf-state-lock"
#   }
# }