#!/usr/bin/env bash
# Actualiza los paquetes existentes
sudo apt update && sudo apt upgrade -y

# Instala los certificados necesarios y curl
sudo apt-get install ca-certificates curl -y

# Crea el directorio para las llaves de APT si no existe
sudo install -m 0755 -d /etc/apt/keyrings

# Descarga la llave GPG oficial de Docker y la guarda en el directorio de llaves
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Asegura que la llave GPG sea legible por todos
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Añade el repositorio de Docker a las fuentes de APT
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualiza la lista de paquetes con los nuevos repositorios
sudo apt-get update

# Instala Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Verifica si el grupo docker existe
if ! getent group docker > /dev/null 2>&1; then
  # Crea el grupo docker si no existe
  sudo groupadd docker
fi

# Nombre de tu usuario
USER_NAME="vagrant"

# Agrega tu usuario al grupo docker
sudo usermod -aG docker "$USER_NAME"

# Utiliza newgrp para aplicar los cambios de grupo sin necesidad de cerrar sesión
newgrp docker

# Reinicia el servicio de Docker
sudo systemctl restart docker

# Verifica si puedes ejecutar Docker sin sudo
docker run hello-world

# Elimina el contenedor hello-world
docker container rm "$(docker container ls -a -q --filter name=hello-world)" -f

# Imprime un mensaje de éxito
echo "Docker ha sido instalado y configurado con éxito."