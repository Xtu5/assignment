#!/bin/bash
#Author: Tyler Vivian
#Creation Date: 25/1/22
#Last Modified: 24/2/22
#Description: Sets a password


mkdir password

#User enteres the password
read -sp "Please type your password" setPassword

#password is then hashed and put into secret.txt in the $folderName
echo $setPassword | sha256sum > ./password/secret.txt

exit 0
