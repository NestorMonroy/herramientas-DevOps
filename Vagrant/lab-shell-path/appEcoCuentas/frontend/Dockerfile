# Etapa de construcción
FROM node:20.12.2-alpine as build-stage

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY package*.json ./

# Instalar dependencias utilizando cache de npm para mejorar la velocidad de construcción
RUN npm ci

# Configurar un tiempo de espera más largo para npm
#RUN npm config set fetch-retry-maxtimeout 120000

# Copia los archivos restantes de tu proyecto Angular
COPY . .

# Construye la aplicación Angular para producción
RUN npm run start
#RUN npm run build:production

# Etapa de ejecución
#FROM nginx:alpine as production-stage
#
## Copia los archivos de distribución de Angular al servidor Nginx
#COPY --from=build-stage /app/dist/frontend /usr/share/nginx/html
#
## Expone el puerto en el que se servirá la aplicación Angular
#EXPOSE 80
#
## Inicia Nginx cuando se ejecute el contenedor
#CMD ["nginx", "-g", "daemon off;"]
