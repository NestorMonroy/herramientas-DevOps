
Crear una red llamada traefik

```sh
docker network create traefik
```

Iniciar 

```sh
docker compose up -d
```

Consultar la ruta
http://whoami.localhost/


Ejecutamos el servicio de books y songs

```sh
cd books
docker compose up -d --build

cd songs
docker compose up -d --build
```