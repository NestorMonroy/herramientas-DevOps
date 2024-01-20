###  Instalar Oracle [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
###  Instalar [Vagrant](https://developer.hashicorp.com/vagrant/install)

### Usuarios en los Box de Vagrant: 

```sh
vagrant
vagrant
root
vagrant

Administrador 
vagrant
```


### Mi primera maquina

Creamos en Vagrantfile completo con todas las opciones comentadas 

```sh
vagrant init bento/centos-7.6
```

Arrancar la máquina virtual

```sh
vagrant up
```

Vemos el estado de la maquina virtual

```sh
vagrant status
vagrant global-status
```

Nos conectamos

```sh
# vía ssh
vagrant ssh

# vía nat
vagrant port

127.0.0.1:2222
localhost:2222
```

Detenemos la maquina virtual

```sh
vagrant halt
```

Para suspenderla del disco:

```sh
vagrant suspen
# Y se reanuda con 
vagrant up

# o con 
vagrant resume

# este último no hace ningún tipo de comprobación sobre el box, etc. simplemente reanuda la máquina desde su estado de suspensión.
```

Busca actualizaciones 

```sh
vagrant box outdated -h
vagrant box outdated --global

```

Actualizar el box

```sh
# Recordar que cuando actualizamos una imagen no se elimina la anterior, sino que mantiene la imagen desactualizada y se descarga la nueva imagen actualizada:

vagrant box update
```

Eliminar un box

```sh
# En el caso de imágenes desactualizadas se pueden eliminar con el comando
vagrant box prune
vagrant remove debian/jessie64 
```

Destruir la maquina virtual y su contenido: 

```sh
vagrant destroy -f
# Borrar la carpeta en el proyecto:	
.vagrant

# Borrar el box del proyecto:
vagrant box --help
vagrant box list
vagrant box remove centos/7 --box-version 1801.02
C:\Users\example\.vagrant.d\boxes
```

### El comando package

Se utiliza para crear un box de vagrant a partir de una maquina virtual de VirtualBox que se este ejecutando. Si tenemos una maquina virtual con toda una configuración se puede pasar a vagrant.

#### Crear un box desde una maquina virtual

Obtenernos el nombre de la máquina virtual, el ejecutable VBoxManage se encuentra: 

```sh
C:\Program Files\Oracle\VirtualBox\VBoxManage list vms
```

La  empaquetamos como un box de vagrant con:

```sh
vagrant package --base "nombre de la maquinavirtual" --output maquina.box
```

Lo importamos como un box a vagrant/VirtualBox

```sh
vagrant box add --name nombre-box maquina.box
vagrant box list 
```

Podemos ver en todo momento los puertos que se han redireccionado con la instrucción:

```sh
vagrant port
```

### Vagrant snapshot

```sh
vagrant snapshot —help
vagrant snapshot save apache-v1
vagrant snapshot restore apache-v1
vagrant snapshot list
vagrant snapshot delete apache-v1
```
