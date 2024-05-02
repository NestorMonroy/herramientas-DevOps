#!/usr/bin/env bash
# Este script

# Función para manejar errores
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Intenta cambiar al directorio del proyecto
echo "Cambiando al directorio del proyecto..."
if cd /vagrant/; then
  echo "Directorio del proyecto encontrado.. Ejecutando docker compose"
  # Intenta crear la app appecocuentas
  if ! docker compose -p appecocuentas up -d --build; then
    error_exit "La creación de appecocuentas falló."
  else
    echo "Se crearon las imágenes"
  fi
else
  error_exit "El directorio del proyecto no existe. Verifique la ruta y vuelva a intentarlo."
fi

#docker build -t nombre_de_la_imagen [opciones y parametros] .
#docker build -t appecocuentas-frontend --no-cache .
#docker compose -p ecocuentas-app --compatibility up -d --build
