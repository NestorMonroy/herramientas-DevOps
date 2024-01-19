# !/bin/bash
# Retrieve new lists of packages
# yum update -y

# Instalar Apache and PHP packages
yum clean all
yum install epel-release -y
yum install mod_ssl httpd php php-mysql mariadb mariadb-server bash-completion -y
yum install httpd php-mysql* -y
systemctl restart httpd

# Instalar Adminer
mkdir /usr/share/adminer && cd /usr/share/adminer
wget -O index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php

cp /vagrant/conf/adminer.conf /etc/httpd/conf.d/adminer.conf

mkdir /codigo
systemctl restart mariadb
systemctl enable httpd mariadb

# Instalar tools
yum install -y unzip tar xz

# Instalar cockpit en https://192.168.33.10:9090/
yum install cockpit* -y
systemctl start cockpit 
systemctl enable cockpit