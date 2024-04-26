#!/bin/bash

# Define la ruta del archivo de configuración de Docker
DOCKER_CONFIG_FILE="/etc/docker/daemon.json"

# Define las direcciones DNS que deseas utilizar
DNS_SERVERS='["1.1.1.1", "8.8.8.8"]'

# Función para configurar las direcciones DNS en el archivo de configuración de Docker
set_dns_servers() {
    if [[ -f "$DOCKER_CONFIG_FILE" ]]; then
        echo "El archivo $DOCKER_CONFIG_FILE ya existe. Actualizando las direcciones DNS..."
        # Utiliza jq para actualizar las direcciones DNS manteniendo el resto del archivo intacto
        jq --argjson servers "$DNS_SERVERS" '.dns = $servers' "$DOCKER_CONFIG_FILE" > temp.json && mv temp.json "$DOCKER_CONFIG_FILE"
    else
        echo "El archivo $DOCKER_CONFIG_FILE no existe. Creando uno nuevo con las direcciones DNS..."
        # Crea un nuevo archivo de configuración con las direcciones DNS
        echo "{\"dns\": $DNS_SERVERS}" > "$DOCKER_CONFIG_FILE"
    fi
}

# Función para reiniciar el servicio de Docker
restart_docker_service() {
    echo "Recargando la configuración del sistema y reiniciando el servicio de Docker..."
    systemctl daemon-reload
    systemctl restart docker.service
}

# Ejecuta las funciones definidas
set_dns_servers
restart_docker_service

# Verifica que el servicio de Docker esté activo
if systemctl is-active --quiet docker.service; then
    echo "El servicio de Docker se ha reiniciado correctamente."
else
    echo "Hubo un problema al reiniciar el servicio de Docker."
fi