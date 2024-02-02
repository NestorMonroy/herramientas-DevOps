#!/bin/bash -e
# 
echo "`date` - Start update CentOS" >> $1
yum update -y
echo "`date` - End update CentOS" >> $1

# Install necessary packages
echo "`date` - Start install penssl-devel bzip2-devel libffi-devel" >> $1
yum install openssl-devel bzip2-devel libffi-devel -y
echo "`date` - End install penssl-devel bzip2-devel libffi-devel" >> $1

# download Python
echo "`date` - Start download Python3.8" >> $1
cd /tmp/
curl -O https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz
tar -xzf Python-3.8.1.tgz
echo "`date` - End download Python3.8" >> $1

# install Python 3
echo "`date` - Start install Python3.8" >> $1
cd /tmp/Python-3.8.1/
./configure --enable-optimizations
make altinstall
echo "`date` - End install Python3.8" >> $1