#!/bin/bash
# ****************************************************
# Program: Apache Install Executable
# Developer: Sander De Vos
# Last Updated: 22/2/2016
# ****************************************************

read -p "What do you want your document root to be called? "  name


mydir=$( cd $(dirname $0) ; pwd -P )

bash $mydir/auto_vhosts.sh "$name"