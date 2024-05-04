# Instrucciones de Configuración del Proyecto

Este documento proporciona una guía paso a paso para configurar y utilizar las herramientas necesarias para este proyecto de desarrollo.

## Configuración de SSH-Agent en Windows

Para configurar el servicio SSH-Agent para que se inicie automáticamente con PowerShell, ejecuta el siguiente comando:

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service
```

## Uso de Vagrant

Vagrant es una herramienta para construir y gestionar entornos de máquinas virtuales de manera sencilla.

### Iniciar Vagrant

Para arrancar la máquina virtual, ejecuta:

```sh
vagrant up
```

### Solución de Problemas

Si encuentras problemas al iniciar Vagrant, guarda el log en un archivo para un análisis más detallado:

```sh
vagrant up --debug *> file.log
```

### Verificar el Estado de la Máquina Virtual

Para verificar el estado actual de la máquina virtual, utiliza:

```sh
vagrant status
vagrant global-status
```

### Conexión a la Máquina Virtual

Puedes conectarte a la máquina virtual utilizando SSH

```sh
# Conexión vía SSH
vagrant ssh

vagrant port

# Direcciones de conexión
127.0.0.1:2222
localhost:2222
```

### Detener la Máquina Virtual

Para detener la máquina virtual, usa:

```sh
vagrant halt
```

### Suspender y Reanudar la Máquina Virtual

Para suspender la máquina virtual al disco y reanudarla después, ejecuta:

```sh
# Suspender
vagrant suspend

# Reanudar
vagrant up
# o
vagrant resume
```

### Actualizar y Eliminar Boxes

Para comprobar si hay actualizaciones de boxes y actualizarlas:

```sh
# Comprobar actualizaciones
vagrant box outdated --global

# Actualizar el box
vagrant box update
```

Para eliminar boxes desactualizados:

```sh
# Eliminar boxes desactualizados
vagrant box prune
```

### Destruir la Máquina Virtual

Para destruir la máquina virtual y su contenido:

```sh
vagrant destroy -f
# Borrar la carpeta .vagrant en el proyecto
rm -rf .vagrant

# Borrar el box del proyecto
vagrant box remove centos/7 --box-version 1801.02
# Ubicación de boxes en Windows
C:\Users\example\.vagrant.d\boxes
```

Recuerda reemplazar`centos/7`y`1801.02`con el nombre y la versión de tu box específico.