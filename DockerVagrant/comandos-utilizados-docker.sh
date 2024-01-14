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
docker run -dtiP --name web1 httpd
docker run -dti -p 8085:80 --name web2 nginx
iptables -t nat -L DOCKER -v -n
