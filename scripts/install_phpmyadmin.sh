#!/bin/bash
# ****************************************************
# Program: PHPMyAdmin Install
# Developer: Sander De Vos
# Last Updated: 22/2/2016
# ****************************************************

echo "****************************************************"
echo "*****************PHPMyAdmin Install*****************"
echo "****************************************************"

brew tap homebrew/dupes
brew tap homebrew/php
brew install phpmyadmin
brew install phpmyadmin

sudo cp /usr/local/share/phpmyadmin/config.sample.inc.php /usr/local/share/phpmyadmin/config.inc.php

#delete section to rewrite.
sudo sed -i -e '/Local Stack Installer BEGIN/,/Local Stack Installer END/ d' /etc/apache2/httpd.conf

text='#*****Local Stack Installer BEGIN*****
Alias /phpmyadmin /usr/local/share/phpmyadmin
<Directory /usr/local/share/phpmyadmin/>
	Options Indexes FollowSymLinks MultiViews
	AllowOverride All
	Require all granted
</Directory>
#*****Local Stack Installer END*****'

#rewrite section
sudo sh -c "echo \"$text\" >> /etc/apache2/httpd.conf"
