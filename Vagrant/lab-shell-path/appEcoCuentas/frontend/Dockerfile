# Etapa de construcción
FROM node:18-alpine as build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY package.json package-lock.json ./

# Instala las dependencias de Node
RUN npm install

# Copia los archivos restantes de tu proyecto Angular
COPY . .

# Construye la aplicación Angular para producción
RUN npm run build --prod

# Etapa de ejecución
FROM nginx:alpine

# Copia los archivos de distribución de Angular al servidor Nginx
COPY --from=build /app/dist/mi-aplicacion-angular /usr/share/nginx/html

# Expone el puerto en el que se servirá la aplicación Angular
EXPOSE 80

# Inicia Nginx cuando se ejecute el contenedor
CMD ["nginx", "-g", "daemon off;"]