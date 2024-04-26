#!/bin/bash

# Definir el directorio NVM
NVM_DIR="/home/vagrant/.nvm"


# Descargar e instalar NVM
echo "Instalando NVM..."
if ! curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 2>&1; then
  echo "La instalación de NVM falló."
  exit 1
else
  echo "NVM instalado correctamente."
fi

# Exportar la variable NVM_DIR y cargar NVM
export NVM_DIR
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
  echo "NVM ha sido cargado correctamente."
else
  echo "El script nvm.sh no se encontró. Asegúrese de que NVM se haya instalado correctamente."
  exit 1
fi

# Instalar una versión específica de Node.js y establecerla como la predeterminada
echo "Instalando Node.js versión 20.12.2..."
if ! nvm install 20.12.2; then
  echo "La instalación de Node.js falló."
  exit 1
else
  echo "Node.js versión 20.12.2 instalado correctamente."
fi


# Establecer la versión de Node.js como la predeterminada
echo "Estableciendo la versión predeterminada de Node.js a 20.12.2..."
if ! nvm alias default 20.12.2; then
  echo "Establecer la versión predeterminada de Node.js falló."
  exit 1
else
  echo "Versión predeterminada de Node.js establecida a 20.12.2."
fi

# Asegurarse de que npm esté disponible
if ! type "npm" > /dev/null; then
  echo "npm no se encuentra disponible. Cargando NVM y reiniciando la sesión de shell..."
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm use default
fi

# Configurar el proxy si es necesario
# Descomenta y reemplaza con tus datos de proxy si es necesario
# npm config set proxy http://<username>:<password>@<proxy-server-url>:<port>
# npm config set https-proxy http://<username>:<password>@<proxy-server-url>:<port>

# Aumentar el tiempo de espera de npm
# npm config set timeout 120000

#echo "Aumentado el tiempo de espera de npm"
#if ! npm config set fetch-timeout 120000 2>&1; then
#  echo "El aumento de npm falló."
#  exit 1
#else
#  echo "Tiempo de espera establecido correctamente."
#fi


# Limpiar la caché de npm
echo "Limpiando la caché de npm..."
if ! npm cache clean --force 2>&1; then
  echo "La limpieza de la caché de npm falló."
  exit 1
else
  echo "Caché de npm limpiada correctamente."
fi

# Instalar Angular CLI
echo "Instalando Angular CLI..."
if ! npm install -g @angular/cli 2>&1; then
  echo "La instalación de Angular CLI falló."
  exit 1
else
  echo "Angular CLI instalado correctamente."
fi

# Cambiar al directorio del proyecto y verificar que el directorio existe
echo "Cambiando al directorio del proyecto..."
if cd /vagrant/; then
  echo "Directorio del proyecto encontrado. Instalando dependencias..."
  # se ejecuta para establecer el tamaño máximo del heap en 4 GB
  if ! node --max-old-space-size=4096 $(which npm) install; then
    echo "La instalación de dependencias falló."
    exit 1
  else
    echo "Dependencias instaladas correctamente."
  fi
else
  echo "El directorio del proyecto no existe. Verifique la ruta y vuelva a intentarlo."
  exit 1
fi

# Definir una variable para la confirmación de autocompletación
CONFIRMAR_AUTO="y"

# Pregunta al usuario si desea habilitar la autocompletación
# read -p "¿Deseas habilitar la autocompletación de Angular CLI? Esto modificará los archivos de configuración en tu directorio home. (Y/n) " -n 1 -r
# echo # Mover a una nueva línea

# Asignar la respuesta del usuario a la variable
# CONFIRMAR_AUTO=$REPLY
# El comando ng completion script agrega una línea al archivo de configuración de tu shell actual
# (por ejemplo, .bashrc o .zshrc) para cargar automáticamente el script de autocompletación de Angular CLI.

if [[ $CONFIRMAR_AUTO =~ ^[Yy]$ ]]
then
    # Agrega el script de autocompletación al archivo .bashrc
    echo "source <(ng completion script)" >> ~/.bashrc
    echo "Autocompletación de Angular CLI habilitada. Por favor, reinicia tu terminal o ejecuta 'source ~/.bashrc' para aplicar los cambios."
else
    echo "Autocompletación de Angular CLI no habilitada."
fi

# Configuración manual:
# Algunos usuarios pueden tener configuraciones de terminal altamente personalizadas.
# Si deseas más control sobre dónde se guarda esta configuración, puedes configurarla manualmente agregando
# la siguiente línea a tu archivo de perfil de shell (por ejemplo, .bashrc o .zshrc):
# source <(ng completion script)

