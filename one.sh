#!/usr/bin/env bash

# Step 1-1
wget -P /etc/apache2/sites-enabled/ -N https://gist.githubusercontent.com/jeff-cald/25bf8e07bf6f08d73bfd35477d7e541e/raw/74fd05f327662ada0c24c59163b595ada97a93e4/wordpress.conf

apachectl restart

wp plugin install https://github.com/jeff-cald/wp-transfer-2019/raw/master/updraftplus.zip --activate --allow-root --path='/var/www/wordpress/'
wp plugin install https://github.com/jeff-cald/wp-transfer-2019/raw/master/wp-optimize-premium-v2.3.4.zip --activate --allow-root --path='/var/www/wordpress/'
