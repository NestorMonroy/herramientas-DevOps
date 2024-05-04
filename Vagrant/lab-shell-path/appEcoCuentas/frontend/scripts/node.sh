#!/bin/bash

# Definir el directorio NVM
#NVM_DIR="/home/vagrant/.nvm"
NVM_DIR="$HOME/.nvm"

# Función para imprimir mensajes de error y salir.
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Función para instalar NVM
install_nvm() {
  echo "Instalando NVM..."
  if ! curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 2>&1; then
    error_exit "La instalación de NVM falló."
  else
    echo "NVM instalado correctamente."
  fi
}

# Función para exportar la variable NVM_DIR y cargar NVM
load_nvm() {
  export NVM_DIR
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
    echo "NVM ha sido cargado correctamente."
  else
    error_exit "El script nvm.sh no se encontró. Asegúrese de que NVM se haya instalado correctamente."
  fi
}

# Función para instalar una versión específica de Node.js y establecerla como la predeterminada
install_node() {
  local version=$1
  echo "Instalando Node.js versión $version..."
  if ! nvm install $version; then
    error_exit "La instalación de Node.js falló."
  else
    echo "Node.js versión $version instalado correctamente."
  fi
}

# Función para establecer la versión predeterminada de Node.js
set_default_node_version() {
  local version=$1
  echo "Estableciendo la versión predeterminada de Node.js a $version..."
  if ! nvm alias default $version; then
    error_exit "Establecer la versión predeterminada de Node.js falló."
  else
    echo "Versión predeterminada de Node.js establecida a $version."
  fi
}


# Función para asegurarse de que npm esté disponible
ensure_npm_available() {
  if ! type "npm" > /dev/null; then
    echo "npm no se encuentra disponible. Cargando NVM y reiniciando la sesión de shell..."
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm use default
  fi
}

# Función para configurar el proxy solo si es necesario
configure_npm_proxy() {
  local username="$1"
  local password="$2"
  local proxy_url="$3"
  local port="$4"

  if [[ -n $username && -n $password && -n $proxy_url && -n $port ]]; then
    echo "Configurando el proxy de npm..."
    npm config set proxy "http://$username:$password@$proxy_url:$port"
    npm config set https-proxy "http://$username:$password@$proxy_url:$port"
    echo "Proxy de npm configurado correctamente."
  else
    echo "No se proporcionaron datos de proxy válidos. Omitiendo la configuración del proxy."
  fi
}


# Función para aumentar el tiempo de espera de npm
increase_npm_timeout() {
  local timeout="$1"

  if [[ -n $timeout ]]; then
    echo "Aumentando el tiempo de espera de npm..."
    if ! npm config set fetch-timeout "$timeout" 2>&1; then
      error_exit "El aumento del tiempo de espera de npm falló."
    else
      echo "Tiempo de espera de npm establecido correctamente a $timeout milisegundos."
    fi
  else
    echo "No se proporcionó un valor de tiempo de espera válido. Omitiendo el aumento del tiempo de espera."
  fi
}

# Función para limpiar la caché de npm
clean_npm_cache() {
  echo "Limpiando la caché de npm..."
  if ! npm cache clean --force 2>&1; then
    error_exit "La limpieza de la caché de npm falló."
  else
    echo "Caché de npm limpiada correctamente."
  fi
}


# Función para instalar Angular CLI
install_angular_cli() {
  echo "Instalando Angular CLI..."
  if ! npm install -g @angular/cli 2>&1; then
    error_exit "La instalación de Angular CLI falló."
  else
    echo "Angular CLI instalado correctamente."
  fi
}


# Función para habilitar la autocompletación de Angular CLI
enable_angular_cli_autocomplete() {
  local confirm_auto=$1
  if [[ $confirm_auto =~ ^[Yy]$ ]]; then
    echo "source <(ng completion script)" >> ~/.bashrc
    echo "Autocompletación de Angular CLI habilitada."
    echo "Para aplicar los cambios, por favor ejecuta el siguiente comando:"
    echo "source ~/.bashrc"
  else
    echo "Autocompletación de Angular CLI no habilitada."
  fi
}

# Función para abrir una nueva terminal y recargar la configuración de la shell
open_new_terminal_and_source() {
  # Intenta detectar el emulador de terminal y ejecutar el comando
  if command -v gnome-terminal &> /dev/null; then
    gnome-terminal -- bash -c "source ~/.bashrc; exec bash"
  elif command -v konsole &> /dev/null; then
    konsole -e bash -c "source ~/.bashrc; exec bash"
  elif command -v xterm &> /dev/null; then
    xterm -e bash -c "source ~/.bashrc; exec bash"
  else
    echo "No se pudo detectar el emulador de terminal. Por favor, abre una nueva terminal y ejecuta 'source ~/.bashrc' manualmente."
  fi
}

# Función para cambiar al directorio del proyecto
change_to_project_directory() {
  local project_dir=$1
  echo "Cambiando al directorio del proyecto..."
  if cd $project_dir; then
    echo "Directorio del proyecto encontrado. Instalando dependencias..."
    if ! node --max-old-space-size=4096 $(which npm) install; then
      error_exit "La instalación de dependencias falló."
    else
      echo "Dependencias instaladas correctamente."
    fi
  else
    error_exit "El directorio del proyecto no existe. Verifique la ruta y vuelva a intentarlo."
  fi
}



# Llamadas a las funciones
install_nvm && load_nvm
install_node "20.12.2" && set_default_node_version "20.12.2"
ensure_npm_available
# configure_npm_proxy "mi_usuario" "mi_contraseña" "proxy.ejemplo.com" "8080"
# increase_npm_timeout "120000"
clean_npm_cache && install_angular_cli
enable_angular_cli_autocomplete "y"
#change_to_project_directory "/vagrant/"





