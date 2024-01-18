
Este es un simple Dockerfile que usa la imagen PHP-Apache y crea un certificado firmado para habilitar el SSL predeterminado. 

Esto es adecuado para el desarrollo y pruebas, no para la producción.


###### Construya y ejecute el contenedor

```sh
docker compose up -d --build
```

Después de ejecutar el comando anterior, debería poder acceder a 

```
http://localhost

https://localhost
```


