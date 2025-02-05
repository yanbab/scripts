#!/usr/bin/env bash
#
# Setup new WordPress install
#

WP_DEST=./
#WP_URL=https://wordpress.org/latest.zip
WP_URL=https://fr.wordpress.org/latest-fr_FR.zip

function _ { echo -e "\n\033[0;33m★ $* \033[0m\n"; } # Pretty print

_ Install WordPress command line tool (wp-cli)

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

_ Get latest WordPress archive

wget $WP_URL
unzip *.zip
rm *.zip
chown -R www-data:www-data *
