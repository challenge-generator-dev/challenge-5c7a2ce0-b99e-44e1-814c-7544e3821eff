# Despliegue de la API de la app de pedidos usando Terraform

El objetivo de este reto es aprovisionar la infraestructura necesaria para desplegar la API de una aplicación móvil de pedidos utilizando Terraform. La aplicación requiere recursos específicos para funcionar de manera eficiente y escalable. Los actores involucrados son el equipo de desarrollo, los usuarios de la aplicación móvil y los servicios externos que consume la API. El dominio es el de una aplicación móvil de pedidos en el sector de la banca y fintech.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto de la API de la aplicación móvil.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los recursos necesarios para la API de la aplicación móvil.
- Configurar el archivo principal de Terraform con los proveedores y las variables necesarias.
- Verificar que la configuración inicial de Terraform sea correcta y esté lista para el siguiente paso.

**Entregable:** Archivo principal de Terraform configurado y listo para aprovisionar recursos.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de Terraform para asegurarte de que los proveedores y las variables están correctamente configurados.
- Utiliza Terraform para definir y gestionar la infraestructura como código.

</details>

### Fase 2: Aprovisionamiento de recursos con Terraform

**Objetivo:** Aprovisionar los recursos necesarios para la API de la aplicación móvil utilizando Terraform.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Definir los recursos de infraestructura necesarios para la API de la aplicación móvil.
- Utilizar Terraform para aprovisionar estos recursos.
- Verificar que los recursos se han aprovisionado correctamente y están listos para su uso.

**Entregable:** Recursos de infraestructura aprovisionados y listos para su uso por la API de la aplicación móvil.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de Terraform para asegurarte de que los recursos se definen y aprovisionan correctamente.
- Utiliza Terraform para aprovisionar la infraestructura como código.

</details>

### Fase 3: Despliegue de la API de la aplicación móvil

**Objetivo:** Desplegar la API de la aplicación móvil en los recursos aprovisionados utilizando Terraform.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configurar la API de la aplicación móvil para que se despliegue en los recursos aprovisionados.
- Utilizar Terraform para aplicar los cambios y desplegar la API.
- Verificar que la API se ha desplegado correctamente y está funcionando como se espera.

**Entregable:** API de la aplicación móvil desplegada y funcionando en los recursos aprovisionados.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de Terraform para asegurarte de que la API se despliega correctamente en los recursos aprovisionados.
- Utiliza Terraform para aplicar los cambios y desplegar la infraestructura como código.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve aprovisionar infraestructura con Terraform en el contexto de una aplicación móvil de pedidos?
- **comoSeUsa**: ¿Cómo se utiliza Terraform para definir y gestionar la infraestructura como código?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de la API de la aplicación móvil en los recursos aprovisionados con Terraform?

## Criterios de Evaluacion

- Configuración inicial de Terraform correcta y lista para aprovisionar recursos.
- Recursos de infraestructura aprovisionados correctamente y listos para su uso.
- API de la aplicación móvil desplegada y funcionando en los recursos aprovisionados.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
