#!/usr/bin/env bash
#
# Initial server setup
#

# Config

SSH_PORT=22
HOSTNAME="localhost"

# Exit if not root

if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

# Print in color

function _ { echo -e "\n\033[0;33m★ $* \033[0m\n"; }
★
_ ★ Initial server setup ★ ★

_ Upgrade system
  apt update
  apt upgrade
  echo "❯ System is up to date"

_ Install Apache2 web server and "Let\'s encrypt"
  echo "❯ Type 'sudo apt remove phpmyadmin' to remove."
  echo "❯ PHPmyAdmin is running on https://localhost/phpmyadmin"
  apt install -y apache2 python3-certbot-apache php

mariadb-server phpmyadmin

_ Install PHPmyAdmin
  apt install -y phpmyadmin
  echo "❯ Type 'sudo apt remove phpmyadmin' to remove."
  echo "❯ PHPmyAdmin is running on https://localhost/phpmyadmin"
  apt install apache2 python3-certbot-apache php mariadb-server phpmyadmin


_ Install Web Console (Cockpit)
  apt install cockpit
  echo "❯ Type 'sudo apt remove cockpit' to remove."
  echo "❯ Cockpit is running on https://localhost:9090"

_ Firewall (ufw)
  apt install -y ufw
  ufw disable
  ufw allow 22
  ufw allow $SSH_PORT
  ufw allow 80
  ufw allow 8080
  ufw allow 9090
  ufw enable
  ufw status
