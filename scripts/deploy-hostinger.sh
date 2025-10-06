#!/usr/bin/env bash
set -euo pipefail

# Usage: bash scripts/deploy-hostinger.sh /home/USER/domains/example.com/public_html
# The path should be the Laravel project root (parent of public/)

PROJECT_ROOT=${1:-"$(pwd)"}
cd "$PROJECT_ROOT"

php -v
composer -V || true

if [ ! -f ".env" ]; then
  echo ".env not found. Create and set production env vars before deploying." >&2
  exit 1
fi

composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

php artisan key:generate --force

php artisan config:cache
php artisan route:cache
php artisan view:cache

php artisan migrate --force
php artisan storage:link || true

chmod -R 775 storage bootstrap/cache || true
# chown -R YOUR_USER:YOUR_GROUP storage bootstrap/cache # Uncomment and adjust if needed

echo "Deploy complete."
