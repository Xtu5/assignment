#!/bin/bash
#Author: Tyler Vivian
#Creation Date: 27/1/22
#Last Modified: 28/2/22
#Description: checks the password that we made with setPassword.sh

Black='\033[30m'
Red='\033[31m'
Green='\033[32m'
Brown='\033[33m'
Blue='\033[34m'
Purple='\033[35m'
Cyan='\033[36m'
Gray='\033[37m'
NC='\033[0m'

#asking for the password
read -sp "Please type your password" typedPassword

#converting to sha256sum
confirmPassword=$(echo $typedPassword | sha256sum)

#test is the file name we set earlier
hashfile="password/secret.txt"

myvariable=$(cat "$hashfile")

#echo "1:$confirmPassword"
#echo "2:$myvariable"

#comparing the passwords
if [ "$confirmPassword" = "$myvariable" ];then

    #success
    echo " "
    echo -e $Green"Access Granted"
    exit 0
else

    #doesn't match
    echo -e $Red"Access Denied"
    exit 1
fi

