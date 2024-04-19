# Utiliza una imagen base de Maven para construir el proyecto
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app-backend

# Copia los archivos fuente y el archivo pom.xml al contenedor
COPY src ./src
COPY pom.xml .

# Ejecuta Maven para limpiar y empaquetar el proyecto, generando el archivo JAR
RUN mvn -f pom.xml clean package -DskipTests

# Verifica que el archivo JAR exista y no esté corrupto
RUN jar -tvf target/*.jar


# Utiliza una imagen base de Java para ejecutar la aplicación
FROM openjdk:17-jdk-alpine

# Copia el archivo JAR desde la etapa de construcción a la etapa de ejecución
COPY --from=build /app-backend/target/*.jar /usr/app/app.jar

# Expone el puerto 8081 y configura el punto de entrada para ejecutar la aplicación
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]
