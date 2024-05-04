#!/usr/bin/env bash
# Este script instala Docker en Ubuntu y realiza configuraciones iniciales.

# Función para imprimir mensajes de error y salir.
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Función para actualizar los paquetes.
update_upgrade_packages() {
    if sudo apt update && sudo apt upgrade -y; then
        echo "Los paquetes han sido actualizados correctamente."
    else
        error_exit "La actualización de los paquetes falló."
    fi
}

# Función para instalar dependencias.
install_dependencies() {
    sudo apt install ca-certificates curl -y || error_exit "La instalación de ca-certificates y curl falló."
}

# Función para configurar el repositorio de Docker.
setup_docker_repository() {
    if ! sudo install -m 0755 -d /etc/apt/keyrings; then
        error_exit "La creación del directorio para las llaves de APT falló."
    fi

    if ! sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc; then
        error_exit "La descarga de la llave GPG de Docker falló."
    fi

    if ! sudo chmod a+r /etc/apt/keyrings/docker.asc; then
        error_exit "La asignación de permisos falló"
    fi
    if  ! echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null; then
        error_exit "La adición del repositorio de Docker a las fuentes de APT falló."
    fi
    if ! sudo apt update; then
        error_exit "La actualización de la lista de paquetes falló."
    fi
}

# Función para instalar Docker.
install_docker() {
    if ! command -v docker &> /dev/null; then
        sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y || error_exit "La instalación de Docker falló."
    else
        echo "Docker ya está instalado en el sistema."
    fi
}

# Función para configurar el grupo de Docker.
configure_docker_group() {
    if ! getent group docker > /dev/null 2>&1; then
        sudo groupadd docker || error_exit "La creación del grupo docker falló."
    fi
    sudo usermod -aG docker "$1" || error_exit "Agregar el usuario al grupo docker falló."
}

# Función para reiniciar Docker y verificar la instalación.
restart_and_verify_docker() {
    sudo systemctl restart docker || error_exit "Reiniciar el servicio de Docker falló."
    if ! docker run hello-world; then
        error_exit "Ejecutar Docker sin sudo falló."
    else
        docker container rm hello-world -f || error_exit "Eliminar el contenedor hello-world falló."
    fi
}

# Nombre de tu usuario.
# user="vagrant"
user=${USER}

# Ejecuta las funciones definidas.
update_upgrade_packages
install_dependencies
setup_docker_repository
install_docker
configure_docker_group "$user"
# newgrp docker
restart_and_verify_docker

# Imprime un mensaje de éxito.
echo "Docker ha sido instalado y configurado con éxito."