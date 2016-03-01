#!/bin/bash
# ****************************************************
# Program: MySQL Install
# Developer: Sander De Vos
# Last Updated: 17/2/2016
# ****************************************************

echo "****************************************************"
echo "*******************MySQL Install********************"
echo "****************************************************"

brew install mysql
mysql.server start

cd /usr/local/share/mysql
mysqladmin -u root password root
cd ~

sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock