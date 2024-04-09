#!/bin/bash

# Definir el directorio NVM
NVM_DIR="/home/vagrant/.nvm"

# Descargar e instalar NVM
echo "Instalando NVM..."
resultado=$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 2>&1)
echo "Resultado de la instalación de NVM:"
echo "$resultado"

# Exportar la variable NVM_DIR y cargar NVM
export NVM_DIR
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"  # This loads nvm
else
  echo "El script nvm.sh no se encontró. Asegúrese de que NVM se haya instalado correctamente."
  exit 1
fi

# Instalar una versión específica de Node.js y establecerla como la predeterminada
echo "Instalando Node.js versión 20.11.1..."
resultado2=$(nvm install 20.11.1 2>&1)
echo "Resultado de la instalación de Node.js:"
echo "$resultado2"

# Establecer la versión de Node.js como la predeterminada
echo "Estableciendo la versión predeterminada de Node.js a 20.11.1..."
resultado3=$(nvm alias default 20.11.1 2>&1)
echo "Resultado de establecer la versión predeterminada de Node.js:"
echo "$resultado3"

echo "cache clean"
resultado4=$(npm cache clean --force 2>&1)
echo "Resultado de la cache clean"
echo "$resultado4"

# Instalar Angular CLI
echo "Instalando Angular CLI"
resultado5=$(npm install -g @angular/cli 2>&1)
echo "Resultado de la instalación de angular"
echo "$resultado5"

# Cambiar al directorio del usuario vagrant
echo "Instalando dependencias"
cd /vagrant/app/ || exit
npm install
