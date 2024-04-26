#!/bin/bash

# Este script agrega una entrada en /etc/fstab para el montaje con mount --bind
sudo apt-get update && sudo apt-get upgrade -y

USUARIO_VAGRANT="vagrant"

RUTA_ORIGINAL="/home/vagrant/vagrant_node_modules"
RUTA_DE_MONTAJE="/vagrant/node_modules"

# Verifica si la carpetas existe, si no, la crea
carpetas_usuario() {
#    if [ -d "$1" ]; then
#        echo "La carpeta $1 ya existe. Borrando..."
#        rm -r "$1"
#    fi

    if [ ! -d "$1" ]; then
        echo "La carpeta $1 no existe. Creando..."
        mkdir -p "$1"
    fi
#    echo "Creando la carpeta $1..."
#    mkdir -p "$1"
    sudo chown -R $USUARIO_VAGRANT:$USUARIO_VAGRANT "$1"
    echo "El propietario de la carpeta $1 ha sido cambiado a $USUARIO_VAGRANT."
}


carpetas_usuario $RUTA_ORIGINAL
carpetas_usuario $RUTA_DE_MONTAJE

# Agrega la entrada en /etc/fstab
echo "$RUTA_ORIGINAL $RUTA_DE_MONTAJE none bind 0 0" | sudo tee -a /etc/fstab

# Monta la carpeta node_modules
sudo mount --bind $RUTA_ORIGINAL $RUTA_DE_MONTAJE

# Verifica que el montaje se ha realizado correctamente
if mountpoint -q $RUTA_DE_MONTAJE; then
    echo "El montaje se ha realizado correctamente."
else
    echo "Hubo un error al realizar el montaje."
fi
