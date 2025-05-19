#!/bin/bash

echo "📦 Pterodactyl Panel Docker Installer - by InfinityForge"
echo "--------------------------------------------------------"

# Directories for volumes
DATA_DIR="./data"
DB_DIR="$DATA_DIR/database"
VAR_DIR="$DATA_DIR/var"
NGINX_DIR="$DATA_DIR/nginx"
CERTS_DIR="$DATA_DIR/certs"
LOGS_DIR="$DATA_DIR/logs"

echo "📁 Creating volume mount directories..."
mkdir -p "$DB_DIR" "$VAR_DIR" "$NGINX_DIR" "$CERTS_DIR" "$LOGS_DIR"

# Fix permissions for Docker mount access
sudo chown -R $USER:$USER "$DATA_DIR"
sudo chmod -R 755 "$DATA_DIR"

echo "🔍 Checking for Docker & Docker Compose plugin..."
if ! command -v docker &> /dev/null
then
    echo "❌ Docker could not be found. Please install Docker."
    exit 1
fi

if ! docker compose version &> /dev/null
then
    echo "❌ Docker Compose plugin could not be found. Please install it."
    exit 1
fi

echo "📝 Writing docker-compose.yml..."
cat > docker-compose.yml <<EOF
version: '3.8'

x-common:
  database:
    &db-environment
    MYSQL_PASSWORD: &db-password "CHANGE_ME"
    MYSQL_ROOT_PASSWORD: "CHANGE_ME_TOO"
  panel:
    &panel-environment
    APP_URL: "http://pterodactyl.example.com"
    APP_TIMEZONE: "UTC"
    APP_SERVICE_AUTHOR: "noreply@example.com"
    TRUSTED_PROXIES: "*"
  mail:
    &mail-environment
    MAIL_FROM: "noreply@example.com"
    MAIL_DRIVER: "smtp"
    MAIL_HOST: "mail"
    MAIL_PORT: "1025"
    MAIL_USERNAME: ""
    MAIL_PASSWORD: ""
    MAIL_ENCRYPTION: "true"

services:
  database:
    image: mariadb:10.5
    restart: always
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - "$PWD/$DB_DIR:/var/lib/mysql"
    environment:
      <<: *db-environment
      MYSQL_DATABASE: "panel"
      MYSQL_USER: "pterodactyl"

  cache:
    image: redis:alpine
    restart: always

  panel:
    image: ghcr.io/pterodactyl/panel:latest
    restart: always
    ports:
      - "8080:8080"
      - "8443:8443"
    depends_on:
      - database
      - cache
    volumes:
      - "$PWD/$VAR_DIR:/app/var/"
      - "$PWD/$NGINX_DIR:/etc/nginx/http.d/"
      - "$PWD/$CERTS_DIR:/etc/letsencrypt/"
      - "$PWD/$LOGS_DIR:/app/storage/logs"
    environment:
      <<: [*panel-environment, *mail-environment]
      DB_PASSWORD: *db-password
      APP_ENV: "production"
      APP_ENVIRONMENT_ONLY: "false"
      CACHE_DRIVER: "redis"
      SESSION_DRIVER: "redis"
      QUEUE_DRIVER: "redis"
      REDIS_HOST: "cache"
      DB_HOST: "database"
      DB_PORT: "3306"

networks:
  default:
    ipam:
      config:
        - subnet: 172.20.0.0/16
EOF

echo "🚀 Starting Pterodactyl Panel with Docker Compose..."
docker compose up -d

echo "✅ Pterodactyl Panel has been started!"
echo "🌐 Access it at: http://localhost:8080 (or your server IP/domain on port 8080)"
