# Módulo de Infraestructura - API de Pedidos

Este módulo aprovisiona la infraestructura necesaria para la API de la aplicación móvil de pedidos del sector fintech.

## Recursos Aprovisionados

- **API Gateway**: Endpoint REST para la API de pedidos
- **Lambda**: Funciones serverless para el procesamiento de solicitudes
- **DynamoDB**: Base de datos NoSQL para persistencia de pedidos
- **Security Groups**: Políticas de seguridad para el acceso a recursos
- **VPC/Networking**: Configuración de red para la infraestructura

## Estructura del Módulo

```
infra/
├── versions.tf          # Configuración de versiones de Terraform y proveedores
├── main.tf              # Definición principal de recursos
├── providers.tf         # Configuración del proveedor AWS
├── variables.tf         # Variables de entrada parametrizables
├── outputs.tf           # Outputs del módulo (URLs, ARNs)
├── terraform.tfvars     # Valores por defecto para variables
└── modules/
    ├── api_gateway/     # Módulo de API Gateway
    ├── lambda/          # Módulo de funciones Lambda
    ├── dynamodb/        # Módulo de base de datos DynamoDB
    ├── security/        # Módulo de políticas de seguridad
    └── networking/      # Módulo de configuración de red
```

## Uso del Módulo

Para utilizar este módulo en un entorno de desarrollo:

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Variables Principales

| Variable | Descripción | Tipo | Valor por defecto |
|----------|-------------|------|-------------------|
| region | Región de AWS donde se aprovisionan los recursos | string | us-east-1 |
| environment | Nombre del entorno (dev, staging, prod) | string | dev |
| api_id | Identificador único para la API en API Gateway | string | pedidos-api |
| table_name | Nombre de la tabla DynamoDB | string | pedidos |
| lambda_runtime | Runtime para las funciones Lambda | string | python3.11 |

## Outputs Exportados

- `api_gateway_endpoint`: URL base del API Gateway
- `lambda_function_arn`: ARN de la función Lambda principal
- `dynamodb_table_arn`: ARN de la tabla DynamoDB
- `security_group_id`: ID del grupo de seguridad

## Validación Local

Para validar la configuración de Terraform localmente:

```bash
terraform validate
terraform fmt -check
terraform plan -out=tfplan
```

## Consideraciones de Seguridad

- Los grupos de seguridad siguen el principio de privilegio mínimo
- Los recursos no exponen puertos sensibles públicamente
- Las funciones Lambda tienen roles con permisos específicos
- El acceso a DynamoDB se realiza mediante IAM policies restrictivas

## Dependencias Externas

- Terraform >= 1.9.5
- Proveedor AWS >= 5.65.0
- AWS CLI configurado con credenciales válidas