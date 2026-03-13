#!/usr/bin/env sh
set -eu

composer install --no-interaction --prefer-dist

exec "$@"
