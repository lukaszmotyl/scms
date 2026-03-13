FROM php:8.3-cli-alpine

WORKDIR /var/www/html

RUN apk add --no-cache \
    bash \
    git \
    icu-dev \
    libzip-dev \
    postgresql-dev \
    rabbitmq-c-dev \
    $PHPIZE_DEPS \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) intl opcache pdo_pgsql zip \
  && pecl install redis amqp \
  && docker-php-ext-enable redis amqp opcache \
  && apk del --no-cache $PHPIZE_DEPS

COPY --from=composer:2.7 /usr/bin/composer /usr/local/bin/composer
COPY .docker/worker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php", "bin/console", "messenger:consume", "async", "--time-limit=0", "--memory-limit=256M", "-vv"]
