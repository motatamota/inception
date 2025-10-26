#!/bin/bash
set -e

# 環境変数の読み込み
DB_NAME=${WORDPRESS_DB_NAME}
DB_USER=${WORDPRESS_DB_USER}
DB_PASS=$(cat ${WORDPRESS_DB_PASSWORD_FILE})
DB_HOST=${WORDPRESS_DB_HOST}

# wp-config.php の自動設定
sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/${DB_PASS}/" /var/www/html/wp-config.php
sed -i "s/localhost/${DB_HOST}/" /var/www/html/wp-config.php

# パーミッション調整
chown -R www-data:www-data /var/www/html

exec "$@"
