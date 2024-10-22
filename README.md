# Mi Proyecto Docker + Jenkins

Este proyecto muestra cómo crear y subir una imagen Docker desde Jenkins.

## Pasos

1. Construir la imagen Docker:
   ```bash
   docker build -t mi-imagen .
   ```
2. Ejecutar la imagen:
   ```bash
   docker run -d mi-imagen
   ```

## Requisitos

- Docker
- Jenkins
