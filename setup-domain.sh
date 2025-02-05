#!/usr/bin/env bash
#
# Create virtual host and database
#

DOMAIN=$1
PASSWORD=$2
PATH="/home"
ROOT="www"

# Init script

if [$# -eq 0]; echo "Usage: $0 my-domain.com"; exit 1; fi # Exit if no argument
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi # Exit if not root
function _ { echo -e "\n\033[0;33m★ $* \033[0m\n"; } # Pretty print
function _in { read; } # Pretty input

_ Password

apt install -y pwgen
PASSWORD=$(pwgen -1)

_ SSH Access

adduser $DOMAIN
mkdir $PATH/$DOMAIN/$ROOT
chmod o+w $PATH/$DOMAIN/$ROOT

_ Apache virtual host

echo -e "
<VirtualHost *:80>
  ServerName $DOMAIN
  ServerAlias www.$DOMAIN
  DocumentRoot $PATH/$DOMAIN/$ROOT
  #LogLevel info ssl:warn
  ErrorLog \$\{APACHE_LOG_DIR}/$DOMAIN-error.log
  CustomLog \$\{APACHE_LOG_DIR}/$DOMAIN-access.log combined
  <Directory />
    AllowOverride All
  </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/$DOMAIN.conf
a2ensite $DOMAIN
systemctl restart apache2

_ Let\'s encrypt HTTPS

certbot --apache -d $DOMAIN -d www.$DOMAIN

