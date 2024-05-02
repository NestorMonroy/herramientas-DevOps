# Etapa de construcción de dependencias
FROM node:20-bullseye-slim AS dependencies
WORKDIR /app

# Copia solo los archivos package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias, esto solo se ejecutará si los archivos package.json o package-lock.json han cambiado
RUN npm config set registry https://registry.npmjs.org/ && \
    npm ci

# Utiliza un volumen para el directorio /tmp para mejorar el rendimiento
VOLUME /tmpfront

# Etapa de construcción de la aplicación
FROM node:20-bullseye-slim AS build-stage
WORKDIR /app

# Copia las dependencias instaladas previamente
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# Construye la aplicación para producción
RUN npm run build:production

# Etapa de ejecución
FROM nginx:alpine AS production-stage
WORKDIR /usr/share/nginx/html

# Copia los archivos de distribución desde la etapa de construcción
COPY --from=build-stage /app/dist/frontend .

# Expone el puerto 80 para el servidor web
EXPOSE 80

# Comando para ejecutar el servidor web Nginx
CMD ["nginx", "-g", "daemon off;"]
