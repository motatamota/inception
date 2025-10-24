#!/bin/bash
set -e

# 環境変数の読み込み
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASS=$(cat ${MYSQL_PASSWORD_FILE})
DB_ROOT_PASS=$(cat ${MYSQL_ROOT_PASSWORD_FILE})

# MariaDB データディレクトリ初期化
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# サービス起動
echo "Starting MariaDB..."
service mariadb start

# 初回セットアップ
echo "Setting up database and user..."
mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
  CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
  GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

# サービス停止（Composeで再起動される想定）
service mariadb stop

echo "MariaDB setup completed."

# 最終的にフォアグラウンドで起動
exec mysqld_safe
