# Guía de instalación y configuración de Docker

**Integrantes:**
Néstor Vélez Vargas

---

## Instalación de Docker Desktop

- Todos los comandos de **PowerShell** deben ejecutarse como **Administrador**.

```powershell
# Instala Docker Desktop desde el repositorio oficial de winget (evita el error de msstore)
winget install -e --id Docker.DockerDesktop --source winget --accept-package-agreements --accept-source-agreements
```

---

## Instalación de Docker Desktop

- Todos los comandos de **PowerShell** deben ejecutarse como **Administrador**.

```powershell
# Instala Docker Desktop desde el repositorio oficial de winget (evita el error de msstore)
winget install -e --id Docker.DockerDesktop --source winget --accept-package-agreements --accept-source-agreements
```

---

## Habilitar características de Windows necesarias

```powershell
# Instala WSL 2 (Windows Subsystem for Linux), requerido por Docker
wsl --install

# Actualiza el kernel de WSL a la última versión disponible
wsl --update

# Establece WSL 2 como la versión predeterminada para nuevas distribuciones
wsl --set-default-version 2

# Habilita Hyper-V, el hipervisor nativo de Windows (requiere reinicio)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Habilita la plataforma de máquina virtual de Windows (necesaria para WSL 2)
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All

# Habilita el soporte nativo para contenedores de Windows
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
```

---

## Verificar instalación de Docker

```bash
# Muestra la versión instalada de Docker
docker --version

# Descarga y corre el contenedor de prueba oficial de Docker
docker run hello-world
```

---



## Levantar cada componente por separado

```bash
# Descargar imagen oficial MySQL 8.0 desde Docker Hub
docker pull mysql:8.0

# Descargar imagen JRE 17 Alpine (base runtime de Quarkus)
docker pull eclipse-temurin:17-jre-alpine

# Descargar imagen Maven 3.9.6 (usada en el build multistage)
docker pull maven:3.9.6-eclipse-temurin-17

# Listar todas las imágenes descargadas localmente
docker images

# Inspeccionar metadatos JSON de la imagen MySQL (capas, env vars, cmd)
docker image inspect mysql:8.0

# Ver historial de capas de la imagen MySQL con tamaños
docker image history mysql:8.0

# Eliminar imagen local específica (solo a modo de ejemplo)
docker rmi eclipse-temurin:17-jre-alpine

# Volver a descargar la imagen eliminada
docker pull eclipse-temurin:17-jre-alpine

# Construir imagen de mysql con la estrucutra y datos base
docker build --no-cache -t poligran-mysql-img ./mysql

# Construir la imagen de la app de quarkus
docker build --no-cache  -t poligran-quarkus-img ./quarkus-app

# Crear la red
docker network create poligran-net

# Ver redes creadas
docker network ls

# Inspeccionar la red: subnet, gateway, contenedores conectados, opciones
docker network inspect poligran-net

# Crear volumen para persistencia de datos
docker volume create poligran-mysql-data

# Ver volumenes creados
docker volume ls

# Inspeccionar volumen: ruta física en host, fecha creación, etiquetas
docker volume inspect poligran-mysql-data

# Ejecutar contenedor MySQL con variables de entorno, red, volumen y puertos
docker run -d --name poligran-mysql  --network poligran-net --restart unless-stopped  -e MYSQL_ROOT_PASSWORD=poligran2024  -e MYSQL_DATABASE=politecnico_db  -e MYSQL_USER=poligran_user  -e MYSQL_PASSWORD=poligran_pass  -p 3306:3306 -v poligran-mysql-data:/var/lib/mysql poligran-mysql-img

# Ver logs de mysql
docker logs -f poligran-mysql

# Ejecutar contenedor de la aplicación Quarkus conectada a la red del proyecto
docker run -d --name poligran-app --network poligran-net --restart unless-stopped -e QUARKUS_DATASOURCE_JDBC_URL="jdbc:mysql://poligran-mysql:3306/politecnico_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Bogota" -e QUARKUS_DATASOURCE_USERNAME=poligran_user -e QUARKUS_DATASOURCE_PASSWORD=poligran_pass  -p 8989:8989 poligran-quarkus-img

# Ver logs de quarkus
docker logs -f poligran-app

# Inspeccionar la red: subnet, gateway, contenedores conectados, opciones
docker network inspect poligran-net

# Listar contenedores en ejecución con ID, imagen, estado y puertos
docker ps

# Detener los contenedores
docker stop poligran-mysql 
docker stop  poligran-app

# Eliminar los contenedores
docker rm -f poligran-mysql 
docker rm -f poligran-app

# Eliminar la red
docker network rm poligran-net

# Eliminar el volumen
docker volume rm poligran-mysql-data

# Borrar imagenes generadas manualmente
docker rmi poligran-net
docker rmi poligran-mysql-data
```

---


## Levantar usando Docker Compose 

```bash
# Construye las imágenes definidas en el archivo docker-compose.yml
docker compose build --no-cache

# Levanta todos los servicios definidos en docker-compose.yml en segundo plano 
docker compose up -d

# Detiene y elimina los contenedores creados por docker compose up
docker compose down
```

---
