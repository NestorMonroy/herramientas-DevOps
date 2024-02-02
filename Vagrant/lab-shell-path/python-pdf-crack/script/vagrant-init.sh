#!/bin/bash -e

echo "`date` - Start install epel-release" >> $1
yum clean all
yum install epel-release -y
echo "`date` - End install epel-release" >> $1

# Instalar tools
echo "`date` - Start install unzip tar xz" >> $1
yum install unzip tar xz -y 
echo "`date` - End install unzip tar xz" >> $1


