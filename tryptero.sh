#!/bin/bash
# Made by Joy - Professional Pterodactyl Auto Installer using Docker

echo "📦 Installing Pterodactyl Panel with Docker..."

# Configuration - Update these values as needed
DB_PASSWORD="StrongDBPassword123"
DB_ROOT_PASSWORD="StrongRootPassword123"
ADMIN_EMAIL="admin@example.com"
ADMIN_NAME="Admin"
ADMIN_PASSWORD="SuperSecureAdminPassword"
ADMIN_USERNAME="adminuser"
PANEL_URL="https://pterodactyl.example.com"
PANEL_TIMEZONE="UTC"

# Step 1: Create directory structure
mkdir -p pterodactyl/panel
cd pterodactyl/panel || exit 1

# Step 2: Create docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.8'

x-common:
  database:
    &db-environment
    MYSQL_PASSWORD: &db-password "$DB_PASSWORD"
    MYSQL_ROOT_PASSWORD: "$DB_ROOT_PASSWORD"
  panel:
    &panel-environment
    APP_URL: "$PANEL_URL"
    APP_TIMEZONE: "$PANEL_TIMEZONE"
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
      - "/srv/pterodactyl/database:/var/lib/mysql"
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
      - "80:80"
      - "443:443"
    links:
      - database
      - cache
    volumes:
      - "/srv/pterodactyl/var/:/app/var/"
      - "/srv/pterodactyl/nginx/:/etc/nginx/http.d/"
      - "/srv/pterodactyl/certs/:/etc/letsencrypt/"
      - "/srv/pterodactyl/logs/:/app/storage/logs"
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

# Step 3: Start Docker containers
echo "🚀 Starting Docker containers..."
docker-compose up -d

# Step 4: Wait for container to fully boot
echo "⏳ Waiting for panel container to be ready..."
sleep 20  # You may adjust this based on server speed



echo "✅ Pterodactyl Panel installation complete!"
echo "🌐 Access your panel at: http://localhost or your-server-ip"
echo "🔐 Admin Login: $Your-EMAIL / Your-pass"

# Step 5: Automatically create an admin user
echo "👤 Creating admin user..."
docker-compose run --rm panel php artisan p:user:make
