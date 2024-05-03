# Frontend

Este proyecto utiliza Angular CLI versión 17.3.0 para su generación y desarrollo.

## Configuración del Entorno de Desarrollo

Ejecuta `ng serve` para levantar un servidor de desarrollo. Visita `http://localhost:4200/`. La aplicación se recargará automáticamente si modificas algún archivo fuente.

## Generación de Código

Utiliza `ng generate component component-name` para crear un nuevo componente. También puedes generar directivas, pipes, servicios, clases, guards, interfaces, enumeraciones y módulos.

## Construcción del Proyecto

Ejecuta `ng build` para construir el proyecto. Los artefactos de la construcción se almacenarán en el directorio `dist/`.

## Pruebas Unitarias

Ejecuta `ng test` para realizar las pruebas unitarias a través de Karma.

## Pruebas de Integración

Ejecuta `ng e2e` para realizar pruebas de extremo a extremo mediante una plataforma de tu elección. Necesitarás añadir un paquete que implemente capacidades de pruebas de integración para usar este comando.

## Ayuda Adicional

Para obtener más ayuda sobre Angular CLI, usa `ng help` o consulta la página de Resumen y Referencia de Comandos de Angular CLI.

## Problemas en npm

### Ejecutar npm con más detalle

Al usar este comando puedes obtener más información sobre lo que está sucediendo durante el proceso de instalación

```
npm install --verbose
```

### Error “JavaScript heap out of memory”

Ocurre cuando Node.js excede el límite de memoria asignado para el heap de JavaScript (heap).. El heap es donde se almacenan los objetos y estructuras de datos dinámicos durante la ejecución de tu aplicación.

```
node --max-old-space-size=8192 $(which npm) install
```

### Error ENOLOCK

Ocurre cuando se intenta ejecutar un comando que requiere un archivo de bloqueo (lockfile), como package-lock.json, y dicho archivo no existe en el proyecto


Si no tienes el archivo `package-lock.json` , puedes crearlo sin instalar paquetes con el comando:

``` 
npm i --package-lock-only
``` 

Una vez que tengas el archivo package-lock.json, puedes ejecutar `npm audit` para que npm realice una auditoría de seguridad.

### Limpieza de caché y resolución de vulnerabilidades

npm almacena en caché los datos para evitar tener que descargar repetidamente paquetes. Sin embargo, la caché puede corromperse o desactualizarse.


#### Limpia la caché de npm

Este comando elimina todos los datos almacenados en la caché de npm. Es útil cuando enfrentas problemas de instalación o conflictos de dependencias que pueden estar relacionados con datos de caché corruptos o desactualizados.

```
npm cache clean --force
```

Después de limpiar la caché, es recomendable verificar su integridad. Esto asegura que la caché esté en buen estado y no contenga datos corruptos que puedan causar problemas.

```
npm cache verify
```

### npm audit

Revisa tus dependencias en busca de vulnerabilidades conocidas

```
npm audit
```

Este comando intenta resolverlas automáticamente, aunque debes usarlo con precaución ya que puede introducir cambios incompatibles.

```
npm audit fix 
```

### Manejo de Dependencias en Node.js

Para resolver problemas con las dependencias en `node_modules`:

#### Uso de legacy-peer-deps

En npm versión 7 y posteriores, se intenta instalar automáticamente las dependencias entre pares (peer dependencies), y el proceso fallará si hay conflictos que no se pueden resolver. 

```
npm config set legacy-peer-deps true
```

Al establecer legacy-peer-deps en true, le indicas a npm que ignore estas dependencias entre pares y no intente resolverlas, lo cual puede ayudar a evitar errores de instalación cuando hay conflictos de versiones.


Limpia y verifica la caché de npm

#### Elimina node_modules y package-lock.json

puedes eliminar la carpeta node_modules y el archivo package-lock.json para forzar una reinstalación limpia de todas las dependencias. Esto puede resolver conflictos y asegurar que todas las dependencias se instalen según las versiones especificadas en tu package.json.

```
rm -rf node_modules
rm -f package-lock.json
```



#### Utiliza npm list 

para ver las dependencias instaladas y sus versiones. Esto te ayudará a identificar y resolver conflictos de versiones actualizando tu package.json o instalando las versiones correctas de los paquetes.

```
npm list
```