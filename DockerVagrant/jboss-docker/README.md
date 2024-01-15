# jboss-docker
Este es un laboratorio para instalar Jboss 6.4 a través de Docker, con un contenedor basado en Centos 7 y optimizado.
Añadimos los ficheros:

standalone.xml -->Está configurado con el driver de mysql
mysql-connector-java-5.1.27-bin.jar--> Driver de mysql para instalarlo en el servidor de Aplicaciones Jboss EAP 6.4
module.xml--> Módulo para base de datos mysql configurado para Jboss EAP 6.4
java.sh--> Para configurar las variables de entorno al contenedor de Jboss con la version de java jdk1.7.0_80

En el proyecto se han utilizado los siguientes archivos que pasamos al contenedor a través del Dockerfile:
-jboss-eap-6.4.0.zip
-jdk-7u80-linux-x64.rpm

# Contruimos la imagen

```sh
docker build --rm -f Dockerfile -t jboss-lab .
```

# Creamos el contenedor

```sh
docker run -dtiP --name jboss1 jboss-lab
```

Validamos que puerto nos asigno docker 

El argumento -P se utiliza para publicar todos los puertos expuestos al azar en el host


```sh
docker logs jboss1
```

Consultamos con el password, puesto en el Dockerfile

username: admin
password: Admin#123

