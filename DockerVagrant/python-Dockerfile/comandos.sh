docker build --no-cache --rm --pull -t aplicacion:v1 . 
docker run -dtiP --name conte1 aplicacion:v1 myaplica.py