# Utiliza una imagen base de Maven para construir el proyecto
FROM maven:3.8.4-eclipse-temurin-17 AS build
WORKDIR /app-backend

# Copia el archivo pom.xml y descarga las dependencias para aprovechar la caché de Docker
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia el código fuente del proyecto
COPY src ./src

# Ejecuta Maven para limpiar y empaquetar el proyecto, generando el archivo JAR
RUN mvn -f pom.xml clean package -DskipTests

# Verifica que el archivo JAR exista y no esté corrupto
RUN jar -tvf target/*.jar

# Utiliza una imagen base de Java para ejecutar la aplicación
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app-backend

# Copia el archivo JAR desde la etapa de construcción a la etapa de ejecución
COPY --from=build /app-backend/target/*.jar app.jar

# Expone el puerto 8081 y configura el punto de entrada para ejecutar la aplicación
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]
