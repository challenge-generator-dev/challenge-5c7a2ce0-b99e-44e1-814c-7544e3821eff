# Configuración de la tabla DynamoDB para persistencia de datos de pedidos
# Superficie de práctica: completar con la configuración necesaria

# Tabla DynamoDB para pedidos
resource "aws_dynamodb_table" "pedidos_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.partition_key
  range_key      = var.sort_key

  attribute {
    name = var.partition_key
    type = "S"
  }

  attribute {
    name = var.sort_key
    type = "S"
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_enabled
  }

  tags = merge(
    var.common_tags,
    {
      Name        = var.table_name
      Environment = var.environment
    }
  )
}

# Punto de acceso global para la tabla (opcional para alta disponibilidad)
resource "aws_dynamodb_global_table" "pedidos_global" {
  count = var.enable_global_tables ? 1 : 0

  name = var.table_name

  replica {
    region_name = var.primary_region
  }

  replica {
    region_name = var.secondary_region
  }

  depends_on = [aws_dynamodb_table.pedidos_table]
}

# Política de backup automático
resource "aws_dynamodb_backup_plan" "pedidos_backup" {
  count = var.enable_backup ? 1 : 0

  name = "pedidos-backup-plan"

  backup_plan {
    rule {
      name             = "daily-backup"
      schedule_expression = var.backup_schedule

      target {
        resources = [aws_dynamodb_table.pedidos_table.arn]
      }
    }
  }
}

resource "aws_dynamodb_backup_vault" "pedidos_vault" {
  count = var.enable_backup ? 1 : 0

  name = "pedidos-backup-vault"

  tags = var.common_tags
}