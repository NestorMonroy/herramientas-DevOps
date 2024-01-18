Cree el volumen que Portainer Server usará para almacenar su base de datos:

```sh
docker volume create portainer_data
```

Descargue e instale el contenedor del servidor Portainer:

```sh
docker compose up -d
```

Puede iniciar sesión en su instancia de servidor de Portainer abriendo un navegador web e ir a:

```
https://localhost:9443
```
