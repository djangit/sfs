#!/bin/bash
# echo "$1"
# echo "$2"
#read -p 'Recaptcha public Key: ' RecaptchaPublicKey
#read -sp 'Recaptcha Private Key: ' RecaptchaPrivateKey

sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/"$1"/g" config.json
sed -i "s/YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY/"$2"/g" config.json
sed -i "s/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/"$1"/g" upload.html

node /opt/Secure_File_Server/index.js
