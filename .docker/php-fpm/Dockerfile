FROM php:8.3-fpm-alpine

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

# Change www-data user and group to match local user (UID/GID 1000)
RUN sed -i 's/^www-data:x:[0-9]\+:[0-9]\+:/www-data:x:1000:1000:/' /etc/passwd && \
    sed -i 's/^www-data:x:[0-9]\+:/www-data:x:1000:/' /etc/group

COPY --from=composer:2.7 /usr/bin/composer /usr/local/bin/composer

COPY .docker/php-fpm/php.ini /usr/local/etc/php/conf.d/zz-scms.ini
COPY .docker/php-fpm/www.conf /usr/local/etc/php-fpm.d/zz-scms.conf

COPY .docker/php-fpm/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm", "-F"]
