# Etapa de construcción
FROM node:20-bullseye-slim as build-stage
# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY package*.json ./

# error ETIMEDOUT
# Configuración de DNS en Docker consultar script docker-DNS.sh
# Asegúrate de que npm no esté configurado para usar uno. Puedes eliminar cualquier configuración de proxy con2:
# RUN npm config delete proxy
# RUN npm config delete https-proxy

# Ejecute el siguiente comando para volver al registro predeterminado
# RUN npm config set registry https://registry.npmjs.org/

# Limpiar la Caché de npm: Ejecuta antes de npm ci para asegurarte de que no haya datos corruptos en la caché que puedan estar causando el problema.
# RUN npm cache clean --force

# Habilita logs más detallados para obtener más información sobre dónde se está atascando el proceso.
#RUN npm ci --verbose
# Se ejecuta para establecer el tamaño máximo del heap en 4 GB
# RUN node --max-old-space-size=4096 $(which npm) install
# RUN npm install --max-old-space-size=512 --no-warnings
# Instalar dependencias utilizando cache de npm para mejorar la velocidad de construcción
RUN npm ci

# Copia los archivos restantes de tu proyecto Angular
COPY . .

# Construye la aplicación Angular para producción
#RUN npm run start
RUN npm run build:production

# Etapa de ejecución
FROM nginx:alpine as production-stage

# Copia los archivos de distribución de Angular al servidor Nginx
COPY --from=build-stage /app/dist/frontend /usr/share/nginx/html

# Expone el puerto en el que se servirá la aplicación Angular
EXPOSE 80

# Inicia Nginx cuando se ejecute el contenedor
CMD ["nginx", "-g", "daemon off;"]
