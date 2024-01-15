# Pasos

Crear una red llamada traefik

```sh
docker network create traefik
```

Ejecutar el traefik

```sh
docker run -d -p 8080:8080 -p 80:80 --network traefik --name traefik -v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock traefik:1.7
```