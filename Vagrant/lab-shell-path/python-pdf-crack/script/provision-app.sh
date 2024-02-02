# !/bin/bash
# Retrieve new lists of packages
# yum update -y

export START_SYSTEM_LOG_FILE=/vagrant/logs/app/app.log
rm -f /vagrant/logs/app/*.log

echo "`date` - Start `echo $0`" > $START_SYSTEM_LOG_FILE

if [ ! -f /vagrant/logs/app/vagrant_init ]; then
    bash /vagrant/script/vagrant-init.sh $START_SYSTEM_LOG_FILE
    mkdir /files
    touch /vagrant/logs/app/vagrant_init
fi

if [ ! -f /vagrant/logs/app/vagrant_python3 ]; then
    bash /vagrant/script/provision-python3.sh $START_SYSTEM_LOG_FILE
    touch /vagrant/logs/app/vagrant_python3
fi
