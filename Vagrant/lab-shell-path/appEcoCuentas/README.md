
## Iniciar vagrant

```sh
vagrant up 
```

### Si tienes problemas

Inicia vagrant y guarda el log en un archivo llamado file.log, para ver más detalle

```sh
vagrant up --debug *> file.log
```

### error ETIMEDOUT

#### Elimina cualquier configuración de proxy

Asegúrate de que npm no esté configurado para usar uno.

```sh
npm config delete https-proxy
npm config delete proxy
```

#### Configura el registro de npm al valor predeterminado

- Esto indica a npm que descargue los paquetes desde el registro oficial de npm. 
- Este registro es una base de datos pública de paquetes de JavaScript que son accesibles para ser instalados mediante el comando npm install.
- Es útil cuando tienes problemas para instalar paquetes y sospechas que puede ser debido a un problema con el registro configurado actualmente.

```sh
npm config set registry https://registry.npmjs.org/
```

#### Limpiar la caché de npm

Para asegurarte de que no haya datos corruptos que puedan estar causando problemas. 

-  Es una buena práctica ejecutarlo antes de `npm ci` para garantizar que cualquier dato corrupto en la caché no afecte la instalación de las dependencias. 

```sh
npm cache clean --force
```

> Si estás utilizando Docker y dependes de su sistema de caché para optimizar la construcción de tus imágenes, debes tener en cuenta que limpiar la caché de npm podría no ser necesario o incluso contraproducente. Docker puede utilizar su propia caché de capas para acelerar la construcción de imágenes, y ejecutar npm cache clean --force podría invalidar esta caché, lo que resultaría en tiempos de construcción más largos.


#### Habilita logs

Para habilitar logs más detallados en npm y obtener más información sobre el proceso de instalación. Esto te proporcionará una salida más detallada en la consola, lo que puede ser útil para diagnosticar problemas.

```sh
npm ci --verbose
```

- Al ejecutar npm ci con la opción --verbose, npm imprimirá información adicional sobre cada paso del proceso de instalación. 
- Esto incluye detalles sobre la descarga de paquetes, la extracción de archivos, y más. 
- Si el proceso se está atascando en algún punto, los logs detallados pueden ayudarte a identificar exactamente dónde y por qué está ocurriendo.

#### Establece el tamaño máximo del heap de Node.js

Es útil si estás experimentando errores de memoria insuficiente durante la instalación de paquetes. Aquí, $(which npm) se utiliza para encontrar la ruta completa del ejecutable de npm en tu sistema y ejecutarlo con ese límite de memoria aumentado.

```sh
node --max-old-space-size=4096 $(which npm) install
```

Este comando hace lo siguiente:

- `--max-old-space-size=4096`: Establece el tamaño máximo del heap de Node.js a 4096 MB (4 GB), lo que puede ser útil si tu proceso de Node.js requiere más memoria de la que se asigna por defecto.
- `$(which npm)`: Encuentra la ruta del ejecutable de npm en tu sistema y la utiliza para ejecutar el comando install.
`install`: Ejecuta npm install, que instalará las dependencias definidas en tu archivo package.json.


#### Configurar el DNS en Docker

La configuración de DNS en Docker es una parte fundamental de la gestión de la red para contenedores, permitiéndoles operar eficientemente dentro de su ecosistema de red asignado.

Revisar [docker-DNS.sh](scripts%2Fdocker-DNS.sh)


