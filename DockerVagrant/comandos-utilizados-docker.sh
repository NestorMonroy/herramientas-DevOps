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
