#!/usr/bin/env bash

# Step 3-1
wp options update home https://$SITE-NAME --allow-root --path='/var/www/wordpress/'

# Step 3-2
a2enmod ssl
apachectl restart

wget -P /etc/apache2/sites-enabled/ -N https://gist.githubusercontent.com/jeff-cald/25bf8e07bf6f08d73bfd35477d7e541e/raw/74fd05f327662ada0c24c59163b595ada97a93e4/wordpress-ssl.conf

