#!/bin/bash

# Define el nombre de usuario para el cual instalar NVM y Node.js

# Función para instalar NVM y Node.js
install_nvm_node() {
  # Instalar NVM (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

  # Cargar NVM
  export NVM_DIR="/usr/local/nvm"
  [ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
  [ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"

  # Instalar la última versión de Node.js
  nvm install node

  # Establecer la versión instalada como la versión por defecto
  nvm alias default node

  # Verificar la instalación
  echo "Node.js version:"
  node -v
  echo "npm version:"
  npm -v
}

install_nvm_node