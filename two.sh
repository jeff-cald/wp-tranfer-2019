#!/usr/bin/env bash

source ./variables

# Step 2-1
wp option update home http://$SITE-NAME --allow-root --path='/var/www/wordpress/'
wp option update siteurl http://$SITE-NAME --allow-root --path='/var/www/wordpress/'

# Step 2-2
wp updraftplus restore $UPDRAFT-SITE-ID --migration --allow-root --path='/var/www/wordpress/'

# Step 2-3
wp plugin install cloudflare --activate --allow-root --path='/var/www/wordpress/'

# Step 2-4
a2enmod rewrite
apachectl restart
