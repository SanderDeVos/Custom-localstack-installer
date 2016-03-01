#!/bin/bash
# ****************************************************
# Program: Git Install
# Developer: Sander De Vos
# Last Updated: 17/2/2016
# ****************************************************

echo "****************************************************"
echo "********************Git install*********************"
echo "****************************************************"

read -p "Enter your GitName: "  name
git config --global user.name "$name"

read -p "Enter GitEmail: "  email
git config --global user.email $email