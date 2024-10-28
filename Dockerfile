# Usamos una imagen base de Ubuntu
FROM ubuntu:20.04

# Actualizamos el sistema y agregamos algunas herramientas básicas
RUN apt-get update && apt-get install -y curl git

# Establecemos el directorio de trabajo
WORKDIR /app

# Copiamos el contenido del repositorio en el contenedor
COPY . .

# Comando por defecto
CMD ["bash"]
