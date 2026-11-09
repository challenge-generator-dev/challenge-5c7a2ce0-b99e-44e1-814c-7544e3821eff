# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/security/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/networking/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://<api-id>.execute-api.<region>.amazonaws.com):
  - `GET /pedidos`
  - `POST /pedidos`
- `client` expone http (api: https://<api-id>.execute-api.<region>.amazonaws.com):
  - `GET /pedidos`
  - `POST /pedidos`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261109074436524), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos usando Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto de la API de la aplicación móvil. — entregable (NO resolver): Archivo principal de Terraform configurado y listo para aprovisionar recursos.
- Fase 2: Aprovisionamiento de recursos con Terraform — objetivo: Aprovisionar los recursos necesarios para la API de la aplicación móvil utilizando Terraform. — entregable (NO resolver): Recursos de infraestructura aprovisionados y listos para su uso por la API de la aplicación móvil.
- Fase 3: Despliegue de la API de la aplicación móvil — objetivo: Desplegar la API de la aplicación móvil en los recursos aprovisionados utilizando Terraform. — entregable (NO resolver): API de la aplicación móvil desplegada y funcionando en los recursos aprovisionados.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/terraform.tfvars ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
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

// === ARCHIVO: infra/modules/lambda/main.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
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

// === ARCHIVO: infra/modules/security/main.tf ===
# Configuracion de politicas de seguridad, roles IAM y permisos necesarios
# SUPERFICIE DE PRACTICA - El estudiante debe implementar la logica de seguridad

# Rol IAM para la Lambda que ejecuta la API
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

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

# Politica de permisos basicos para Lambda
resource "aws_iam_policy" "lambda_basic_execution" {
  name        = "lambda_basic_execution"
  description = "Politica de ejecucion basica para Lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Adjuntar politica al rol
resource "aws_iam_role_policy_attachment" "lambda_basic_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_basic_execution.arn
}

# Politica de acceso a DynamoDB para la tabla de pedidos
resource "aws_iam_policy" "dynamodb_access" {
  name        = "dynamodb_pedidos_access"
  description = "Permisos de acceso a la tabla de pedidos en DynamoDB"

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
        Resource = "arn:aws:dynamodb:*:*:table/pedidos"
      }
    ]
  })
}

# Adjuntar politica de DynamoDB al rol
resource "aws_iam_role_policy_attachment" "dynamodb_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# Grupo de seguridad para API Gateway
resource "aws_security_group" "api_gateway_sg" {
  name        = "api_gateway_security_group"
  description = "Grupo de seguridad para API Gateway"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS inbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "api_gateway_sg"
    Environment = var.environment
  }
}

# Grupo de seguridad para Lambda
resource "aws_security_group" "lambda_sg" {
  name        = "lambda_security_group"
  description = "Grupo de seguridad para funciones Lambda"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.api_gateway_sg.id]
    description     = "Allow HTTPS from API Gateway"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS outbound"
  }

  tags = {
    Name        = "lambda_sg"
    Environment = var.environment
  }
}

# Grupo de seguridad para DynamoDB
resource "aws_security_group" "dynamodb_sg" {
  name        = "dynamodb_security_group"
  description = "Grupo de seguridad para DynamoDB"
  vpc_id      = var.vpc_id

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]
    description     = "Allow HTTPS to Lambda"
  }

  tags = {
    Name        = "dynamodb_sg"
    Environment = var.environment
  }
}

// === ARCHIVO: infra/modules/networking/main.tf ===
# Configuracion de redes, VPC y subredes para la infraestructura
# SUPERFICIE DE PRACTICA - El estudiante debe implementar la configuracion de red

# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "pedidos_app_vpc"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "pedidos_app_igw"
    Environment = var.environment
  }
}

# Tabla de rutas principal
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "pedidos_app_route_table"
    Environment = var.environment
  }
}

# Subred publica 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos_public_subnet_1"
    Environment = var.environment
  }
}

# Subred publica 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos_public_subnet_2"
    Environment = var.environment
  }
}

# Subred privada 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name        = "pedidos_private_subnet_1"
    Environment = var.environment
  }
}

# Subred privada 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name        = "pedidos_private_subnet_2"
    Environment = var.environment
  }
}

# Asociar subredes publicas a la tabla de rutas
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.main.id
}

# Tabla de rutas para subredes privadas (NAT Gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "pedidos_private_route_table"
    Environment = var.environment
  }
}

# Asociar subredes privadas a la tabla de rutas privada
resource "aws_route_table_association" "private_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "pedidos_nat_eip"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name        = "pedidos_nat_gateway"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]
}

# Ruta desde subredes privadas a NAT Gateway
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

// === ARCHIVO: client/pubspec.yaml ===
name: pedidos_app
description: Aplicación móvil de pedidos para el sector fintech.
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'
  flutter: '>=3.27.0'

dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
  provider: ^6.1.2
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5

  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.3

flutter:
  uses-material-design: true

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/domain/usecases/get_pedidos.dart';
import 'package:pedidos_app/data/repositories/pedido_repository.dart';
import 'package:pedidos_app/presentation/screens/pedidos_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PedidoRepository>(create: (_) => PedidoRepository()),
        ProxyProvider<PedidoRepository, GetPedidos>(
          update: (_, repository, __) => GetPedidos(repository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedidos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PedidosScreen(),
    );
  }
}

// === ARCHIVO: client/lib/domain/entities/pedido.dart ===
import 'package:equatable/equatable.dart';

class Pedido extends Equatable {
  final String id;
  final String usuarioId;
  final List<String> items;
  final double total;
  final String estado;
  final DateTime fechaCreacion;

  const Pedido({
    required this.id,
    required this.usuarioId,
    required this.items,
    required this.total,
    required this.estado,
    required this.fechaCreacion,
  });

  @override
  List<Object?> get props => [id, usuarioId, items, total, estado, fechaCreacion];

  Pedido copyWith({
    String? id,
    String? usuarioId,
    List<String>? items,
    double? total,
    String? estado,
    DateTime? fechaCreacion,
  }) {
    return Pedido(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      items: items ?? this.items,
      total: total ?? this.total,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}

// === ARCHIVO: client/lib/domain/usecases/get_pedidos.dart ===
import 'package:pedidos_app/domain/entities/pedido.dart';
import 'package:pedidos_app/domain/repositories/pedido_repository_contract.dart';

class GetPedidos {
  final PedidoRepositoryContract repository;

  GetPedidos(this.repository);

  Future<List<Pedido>> call() async {
    try {
      final pedidos = await repository.getPedidos();
      if (pedidos.isEmpty) {
        throw Exception('No se encontraron pedidos');
      }
      return pedidos;
    } catch (e) {
      throw Exception('Error al obtener pedidos: $e');
    }
  }
}

class CreatePedido {
  final PedidoRepositoryContract repository;

  CreatePedido(this.repository);

  Future<Pedido> call(CreatePedidoRequest request) async {
    try {
      if (request.items.isEmpty) {
        throw Exception('La lista de items no puede estar vacía');
      }
      if (request.total <= 0) {
        throw Exception('El total debe ser mayor que cero');
      }
      return await repository.createPedido(request);
    } catch (e) {
      throw Exception('Error al crear pedido: $e');
    }
  }
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application
        android:label="Pedidos App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/repositories/pedido_repository.dart ===
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/pedido.dart';
import '../../domain/usecases/get_pedidos.dart';

abstract class PedidoRepositoryContract {
  Future<List<Pedido>> getPedidos();
  Future<Pedido> createPedido(CreatePedidoRequest request);
}

class PedidoRepository implements PedidoRepositoryContract {
  final http.Client _httpClient;
  final String _baseUrl;
  
  PedidoRepository({
    http.Client? httpClient,
    String? baseUrl,
  }) : _httpClient = httpClient ?? http.Client(),
       _baseUrl = baseUrl ?? const String.fromEnvironment(
         'API_BASE_URL',
         defaultValue: 'https://api.pedidos.example.com',
       );

  @override
  Future<List<Pedido>> getPedidos() async {
    try {
      final uri = Uri.parse('$_baseUrl/pedidos');
      final response = await _httpClient.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw PedidoRepositoryException(
          'Tiempo de conexión agotado. Verifica tu conexión a internet.',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => _pedidoFromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw PedidoRepositoryException('No autorizado. Inicia sesión nuevamente.');
      } else if (response.statusCode == 404) {
        throw PedidoRepositoryException('Recurso no encontrado.');
      } else if (response.statusCode >= 500) {
        throw PedidoRepositoryException('Error del servidor. Intenta más tarde.');
      } else {
        throw PedidoRepositoryException(
          'Error al obtener pedidos. Código: ${response.statusCode}',
        );
      }
    } on PedidoRepositoryException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('SocketException') || 
          e.toString().contains('HandshakeException')) {
        throw PedidoRepositoryException(
          'No se pudo conectar al servidor. Verifica tu conexión.',
        );
      }
      throw PedidoRepositoryException('Error inesperado: ${e.toString()}');
    }
  }

  @override
  Future<Pedido> createPedido(CreatePedidoRequest request) async {
    try {
      final uri = Uri.parse('$_baseUrl/pedidos');
      final response = await _httpClient.post(
        uri,
        headers: _buildHeaders(contentType: 'application/json'),
        body: json.encode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw PedidoRepositoryException(
          'Tiempo de conexión agotado. Verifica tu conexión a internet.',
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return _pedidoFromJson(jsonData);
      } else if (response.statusCode == 400) {
        final errorBody = json.decode(response.body);
        throw PedidoRepositoryException(
          errorBody['message'] ?? 'Datos inválidos. Verifica los campos.',
        );
      } else if (response.statusCode == 401) {
        throw PedidoRepositoryException('No autorizado. Inicia sesión nuevamente.');
      } else if (response.statusCode == 409) {
        throw PedidoRepositoryException('El pedido ya existe.');
      } else if (response.statusCode >= 500) {
        throw PedidoRepositoryException('Error del servidor. Intenta más tarde.');
      } else {
        throw PedidoRepositoryException(
          'Error al crear pedido. Código: ${response.statusCode}',
        );
      }
    } on PedidoRepositoryException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('SocketException') || 
          e.toString().contains('HandshakeException')) {
        throw PedidoRepositoryException(
          'No se pudo conectar al servidor. Verifica tu conexión.',
        );
      }
      throw PedidoRepositoryException('Error inesperado: ${e.toString()}');
    }
  }

  Map<String, String> _buildHeaders({String? contentType}) {
    final headers = <String, String>{
      'Accept': 'application/json',
    };
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }
    return headers;
  }

  Pedido _pedidoFromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] as String,
      usuarioId: json['usuarioId'] as String,
      items: List<String>.from(json['items'] ?? []),
      total: (json['total'] as num).toDouble(),
      estado: json['estado'] as String,
      fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
    );
  }

  void dispose() {
    _httpClient.close();
  }
}

class PedidoRepositoryException implements Exception {
  final String message;
  PedidoRepositoryException(this.message);
  
  @override
  String toString() => message;
}

// === ARCHIVO: client/lib/presentation/screens/pedidos_screen.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/usecases/get_pedidos.dart';
import '../../data/repositories/pedido_repository.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<Pedido> _pedidos = [];
  bool _isLoading = false;
  String? _errorMessage;
  PedidoRepository? _repository;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndLoad();
    });
  }

  Future<void> _initializeAndLoad() async {
    _repository ??= Provider.of<PedidoRepository>(context, listen: false);
    await loadPedidos();
  }

  Future<void> loadPedidos() async {
    if (_repository == null) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final getPedidosUseCase = GetPedidos(_repository!);
      final pedidos = await getPedidosUseCase();
      setState(() {
        _pedidos = pedidos;
        _isLoading = false;
      });
    } on PedidoRepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado al cargar pedidos.';
        _isLoading = false;
      });
    }
  }

  Future<void> _createPedido() async {
    if (_repository == null) return;

    final request = CreatePedidoRequest(
      usuarioId: 'usuario_001',
      items: ['Producto A', 'Producto B'],
      total: 150.00,
    );

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final createPedidoUseCase = CreatePedido(_repository!);
      final nuevoPedido = await createPedidoUseCase(request);
      setState(() {
        _pedidos = [..._pedidos, nuevoPedido];
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pedido ${nuevoPedido.id} creado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on PedidoRepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado al crear pedido.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : loadPedidos,
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _createPedido,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _pedidos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando pedidos...'),
          ],
        ),
      );
    }

    if (_errorMessage != null && _pedidos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: loadPedidos,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (_pedidos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No tienes pedidos aún',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Toca el botón + para crear tu primer pedido',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (_errorMessage != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _errorMessage = null),
                ),
              ],
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: loadPedidos,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _pedidos.length,
              itemBuilder: (context, index) {
                return _PedidoCard(
                  pedido: _pedidos[index],
                  onTap: () => _showPedidoDetalle(_pedidos[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showPedidoDetalle(Pedido pedido) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Pedido #${pedido.id}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _DetailRow(label: 'Estado', value: pedido.estado),
                _DetailRow(label: 'Total', value: '\$${pedido.total.toStringAsFixed(2)}'),
                _DetailRow(
                  label: 'Fecha', 
                  value: '${pedido.fechaCreacion.day}/${pedido.fechaCreacion.month}/${pedido.fechaCreacion.year}',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...pedido.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(item),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PedidoCard extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onTap;

  const _PedidoCard({
    required this.pedido,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${pedido.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _EstadoBadge(estado: pedido.estado),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Usuario: ${pedido.usuarioId}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${pedido.items.length} items',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    '\$${pedido.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(pedido.fechaCreacion),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _EstadoBadge extends StatelessWidget {
  final String estado;

  const _EstadoBadge({required this.estado});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    
    switch (estado.toLowerCase()) {
      case 'completado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pendiente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'cancelado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'procesando':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        estado,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// === ARCHIVO: client/lib/services/api_service.dart ===
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/entities/pedido.dart';
import '../domain/usecases/get_pedidos.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<List<Pedido>> getPedidos() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pedidos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => _pedidoFromJson(json)).toList();
      } else {
        throw ApiException(
          message: 'Error al obtener pedidos',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        message: 'Error de conexión: ${e.message}',
        statusCode: null,
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Error al parsear respuesta: ${e.message}',
        statusCode: null,
      );
    }
  }

  Future<Pedido> createPedido(CreatePedidoRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/pedidos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return _pedidoFromJson(jsonData);
      } else {
        throw ApiException(
          message: 'Error al crear pedido',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        message: 'Error de conexión: ${e.message}',
        statusCode: null,
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Error al parsear respuesta: ${e.message}',
        statusCode: null,
      );
    }
  }

  Pedido _pedidoFromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] as String,
      usuarioId: json['usuarioId'] as String,
      items: List<String>.from(json['items'] as List),
      total: (json['total'] as num).toDouble(),
      estado: json['estado'] as String,
      fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
    );
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}

// === ARCHIVO: client/lib/domain/repositories/pedido_repository_contract.dart ===
import 'package:pedidos_app/domain/entities/pedido.dart';

abstract class PedidoRepositoryContract {
  Future<List<Pedido>> getPedidos();
  Future<Pedido> createPedido(CreatePedidoRequest request);
}

class CreatePedidoRequest {
  final String usuarioId;
  final List<String> items;
  final double total;

  CreatePedidoRequest({
    required this.usuarioId,
    required this.items,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'items': items,
      'total': total,
    };
  }
}
```
