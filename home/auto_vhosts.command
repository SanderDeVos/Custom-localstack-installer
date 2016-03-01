#!/bin/bash
# ****************************************************
# Program: Apache Install
# Developer: Sander De Vos
# Last Updated: 22/2/2016
# ****************************************************

read -p "What is your document root folder called? "  name
docroot="/Users/$USER/$name"

#Delete dummy vhosts
linenumber=$(awk '/dummy/{ print NR; exit }' /etc/apache2/extra/httpd-vhosts.conf)
startnumber=$(($linenumber-1))
endnumber=$(($startnumber+15))
if [ "$startnumber" == "23" ] ; then
	sudo sed -i -e "$startnumber,$endnumber d" /etc/apache2/extra/httpd-vhosts.conf
fi


#delete section to rewrite.
sudo sed -i -e '/Local Stack Installer BEGIN/,/Local Stack Installer END/ d' /etc/hosts

#delete section to rewrite.
sudo sed -i -e '/Local Stack Installer BEGIN/,/Local Stack Installer END/ d' /etc/apache2/extra/httpd-vhosts.conf

vhosts="#*****Local Stack Installer BEGIN*****

<VirtualHost *:80>
ServerName localhost
DocumentRoot \"/Users/$USER/$name/home\"
ErrorLog \"/private/var/log/apache2/home.localhost-error_log\"
CustomLog \"/private/var/log/apache2/home.localhost-access_log\" common
</VirtualHost>

"

hosts="#*****Local Stack Installer BEGIN*****

"


for d in $docroot/* ; do
	if [ -d "${d}" ] ; then
	naam=$(basename "$d")
		if [ "$naam" != "home" ] && [ "$naam" != "sqldumps" ]; then
    		vhosts+="<VirtualHost *:80>
ServerName $naam.localhost
DocumentRoot \"/Users/$USER/$name/$naam\"
ErrorLog \"/private/var/log/apache2/$naam.localhost-error_log\"
CustomLog \"/private/var/log/apache2/$naam.localhost-access_log\" common
</VirtualHost>

"

			hosts+="127.0.0.1	$naam.localhost

"
		fi
    fi
done

vhosts+="#*****Local Stack Installer END*****"
hosts+="#*****Local Stack Installer END*****"
#rewrite section
sudo sh -c "echo \"$hosts\" >> /etc/hosts"

#rewrite section
sudo sh -c "echo \"$vhosts\" >> /etc/apache2/extra/httpd-vhosts.conf"

#restart apache for changes to apply
sudo apachectl -k restart