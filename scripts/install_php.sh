#!/bin/bash
# ****************************************************
# Program: PHP Install
# Developer: Sander De Vos
# Last Updated: 17/2/2016
# ****************************************************

echo "****************************************************"
echo "*********************PHP Install********************"
echo "****************************************************"

sudo cp /etc/php.ini.default /etc/php.ini

sudo sed -i -e '/^session.cache_limiter/s/session.cache_limiter.*/session.cache_limiter = nocache/' /etc/php.ini
sudo sed -i -e '/^session.auto_start/s/session.auto_start.*/session.auto_start = 0/' /etc/php.ini
sudo sed -i -e '/^expose_php/s/expose_php.*/expose_php = Off/' /etc/php.ini
sudo sed -i -e '/^allow_url_fopen/s/allow_url_fopen.*/allow_url_fopen = Off/' /etc/php.ini
sudo sed -i -e '/^display_errors/s/display_errors.*/display_errors = Off/' /etc/php.ini
sudo sed -i -e '/memory_limit/s/memory_limit.*/memory_limit = 256M/' /etc/php.ini