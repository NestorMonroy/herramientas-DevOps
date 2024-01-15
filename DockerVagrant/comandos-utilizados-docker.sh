# parar todo los contenedores:
docker stop $(docker ps -aq)

# Eliminar todos  los contenedores:
docker rm $(docker ps  -aq)

# Eliminar todos  los contenedores en estado Exited 
docker rm  $(docker ps  -a -f status=exited -q)

# Trabajar con imágenes
docker images
docker search nginx
docker pull nginx
docker search  --filter=stars=20 nginx 
docker history nginx
docker inspect nginx
docker rmi nginx
docker rmi -f nginx
docker rmi  --help

# Lanzar contenedores
docker run --help
docker run  -dti --rm --name webl httpd
docker run  -dti  --name web2  httpd
docket run  -dti nginx

docker inspect webl
# Para  ver  los  contenedores corriendo: 
docker ps  -a
docker ps  -l

# interactuar con los contenedores
docker exec -ti webl /bin/bash
docker stop nombre-contenedor
docker start nombre-contenedor
docker rm nombre-contenedor
docker rm -f nombre-contenedor
docker logs nombre-contenedor
docker logs -f nombre-contenedor
docker logs -t nombre-contenedor


docker stop nombre-contenedor
docker start nombre-contenedor
docker restart nombre-contenedor
docker pause nombre-contenedor
docker unpause nombre-contenedor

# Para ver las estadisticas de los contenedores y modificar en caliente la memoria de un contenedor
docker stats
docker update -m 200M --memory-swap -l  nombre-contenedor

# Para natear puertos y llegar a los servicios de los contenedores
docker run -dtiP --name web1 httpd # -P puerto alateario
docker run -dti -p 8085:80 --name web2 nginx # -p puerto especifico
iptables -t nat -L DOCKER -v -n
docker port nombre-contenedor

# Listar redes
docker network ls [opciones]

# Crear redes
docker network create [opciones] nombre

# Crear red con Rango Especificado
docker network create --subnet 192.168.100.1/24 --ip-range 192.168.100.100/30 --gateway 192.168.100.100 produccion


# Enlazar dos contenedore y persistiendo volúmenes:
docker run -dti —name servidor_mysql -e MYSQL_ROOT_PASSWORD-000000 -v /bd:/var/lib/mysql mysql:5.7 
docker run -dti —name servidor_wp -p 85:80 --link servidor_mysql:mysql wordpress:5.6.2-php7.3


mkdir /web
# Ejecutamos un contenedor utilizando un volumen con el directorio del servidor:
docker run -dtiP --name centos6-prueba-web -v /web:/var/www/html docker.io/nickistre/centos-lamp 
docker run -dtiP --name centos6-prueba-web2 -v /web:/var/www/html docker.io/nickistre/centos-lamp

# Ejemplo crear un volumen con un nombre especifico: 
docker volume create --name webapp
docker volumne ls
docker volume inspect webapp
# "Mountpoint":   ”/var/lib/docker/volumes/webapp/_data",

# Creamos un fichero desde el servidor Docker dentro del volumen:
echo "prueba de volumen" > /var/lib/docker/volumes/webapp/_data/ejemplo.txt

docker run -dtiP —name centos6-pruebacreacion2 -v webapp:/var/www/html docker.io/nickistre/centos-lamp

# Docker-Compose

docker compose up
docker compose down
docker compose logs [nombre-contenedor]
