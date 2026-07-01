# Backend 2 - Product Service

API REST en Python/Flask para gestión de productos, desplegada en AWS ECS Fargate con base de datos MySQL en Amazon RDS.

## Arquitectura

- **Tecnología**: Python 3.11 + Flask + MySQL Connector
- **Contenedor**: Docker
- **Orquestación**: AWS ECS Fargate
- **Base de datos**: Amazon RDS MySQL 8.0 (`products_db`)
- **Secrets**: Credenciales de BD almacenadas en AWS SSM Parameter Store
- **Logs**: CloudWatch Logs (`/ecs/product-service`)

## Endpoints

| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | `/api/products` | Obtener todos los productos |
| GET | `/api/products/:id` | Obtener producto por ID |
| POST | `/api/products` | Crear nuevo producto |
| PUT | `/api/products/:id` | Actualizar producto |
| DELETE | `/api/products/:id` | Eliminar producto |
| GET | `/api/products/search` | Buscar productos por nombre/precio/stock |

## Pipeline CI/CD

Cada commit a `main` dispara automáticamente el workflow `.github/workflows/deploy.yml`:
1. **Build**: construye la imagen Docker
2. **Push**: sube la imagen a Amazon ECR
3. **Deploy**: fuerza un nuevo despliegue en ECS

## Variables de entorno

| Variable | Descripción | Fuente |
|----------|-------------|--------|
| `DB_HOST` | Host de RDS MySQL | SSM Parameter Store |
| `DB_PASSWORD` | Contraseña de la BD | SSM Parameter Store (SecureString) |
| `DB_PORT` | Puerto MySQL (3306) | Task Definition |
| `DB_USER` | Usuario MySQL (admin) | Task Definition |
| `DB_NAME` | Nombre de la BD (products_db) | Task Definition |
| `PORT` | Puerto del servidor (8082) | Task Definition |

## Autoscaling

Configurado con Target Tracking al 50% de CPU:
- Mínimo: 1 task
- Máximo: 3 tasks

## Cómo ejecutar localmente

```bash
cp .env.example .env
# Editar .env con credenciales locales
pip install -r requirements.txt
python app.py
```

## Estructura del proyecto
BackPy_Eval3/
├── app.py                     # API REST principal
├── requirements.txt           # Dependencias Python
├── Dockerfile                 # Imagen Docker
└── .github/workflows/
└── deploy.yml             # Pipeline CI/CD
