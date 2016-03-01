#!/bin/bash
# ****************************************************
# Program: Local Stack Installation Script
# Developer: Sander De Vos
# Last Updated: 17/2/2016
# ****************************************************

read -p "What do you want your document root to be called? "  name
mkdir /Users/$USER/$name

mydir=$( cd $(dirname $0) ; pwd -P )

bash $mydir/scripts/install_homebrew.sh
bash $mydir/scripts/install_php.sh
bash $mydir/scripts/install_mysql.sh
bash $mydir/scripts/install_apache.sh "$name"
bash $mydir/scripts/install_phpmyadmin.sh
bash $mydir/scripts/install_drush.sh
bash $mydir/scripts/install_git.sh
bash $mydir/scripts/install_sass-compass.sh

cp -r $mydir/home /Users/$USER/$name/home