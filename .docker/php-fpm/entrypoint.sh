#!/usr/bin/env sh
set -eu

if [ ! -d vendor ]; then
  composer install --no-interaction --prefer-dist
fi

php bin/console doctrine:migrations:migrate --no-interaction || true

exec "$@"
