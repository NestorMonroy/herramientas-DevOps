# Etapa de construcción de dependencias
FROM maven:3.8.4-eclipse-temurin-17 AS build
WORKDIR /app-backend

# Aprovecha la caché de capas de Docker para las dependencias
COPY pom.xml .
RUN mvn dependency:resolve

# Copia el código fuente del proyecto
COPY src ./src

# Compila y empaqueta la aplicación sin ejecutar pruebas
RUN mvn clean package -DskipTests

# Etapa de ejecución
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app-backend

# Crear un grupo y usuario no root para ejecutar la aplicación
RUN addgroup -g 1028 devops \
    && adduser -D -G devops -u 1029 admin

# Crea un punto de montaje para usar el volumen para /tmp
VOLUME /tmpback

# Copia el JAR desde la etapa de construcción
COPY --from=build /app-backend/target/*.jar app.jar

# Cambia la propiedad del JAR al usuario no root 'admin'
RUN chown admin:devops app.jar

# Cambia al usuario 'admin' para ejecutar la aplicación
USER admin

# Expone el puerto que utiliza la aplicación
EXPOSE 8081

# Define el punto de entrada de la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]