#!/bin/bash
# ****************************************************
# Program: Apache Install
# Developer: Sander De Vos
# Last Updated: 22/2/2016
# ****************************************************

echo "****************************************************"
echo "*******************Apache Install*******************"
echo "****************************************************"

line1="DocumentRoot \"/Users/$USER/$1\""
line2="<Directory \"/Users/$USER/$1\">"

echo "$line1"

sudo sed -i -e "236s|.*DocumentRoot.*|$line1|" /private/etc/apache2/httpd.conf
sudo sed -i -e "237s|.*Directory.*|$line2|" /private/etc/apache2/httpd.conf
sudo sed -i -e '250s/.*Options.*/Options Indexes FollowSymLinks Multiviews/' /private/etc/apache2/httpd.conf
sudo sed -i -e '258s/.*AllowOverride.*/AllowOverride All/' /private/etc/apache2/httpd.conf

sudo sed -i -e 's|.*php5_module.*|LoadModule php5_module libexec/apache2/libphp5.so|' /private/etc/apache2/httpd.conf
sudo sed -i -e 's|.*httpd-vhosts.conf.*|Include /private/etc/apache2/extra/httpd-vhosts.conf|' /private/etc/apache2/httpd.conf
sudo sed -i -e 's|.*vhost_alias_module.*|LoadModule vhost_alias_module libexec/apache2/mod_vhost_alias.so|' /private/etc/apache2/httpd.conf

sudo sed -i -e "/^User/s/User.*/User $USER/" /private/etc/apache2/httpd.conf
sudo sed -i -e '/^Group/s/Group.*/Group staff/' /private/etc/apache2/httpd.conf

#automatically add sites to vhosts and hosts
mydir=$( cd $(dirname $0) ; pwd -P )
bash $mydir/auto_vhosts.sh "$1"