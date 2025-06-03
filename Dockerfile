# syntax=docker/dockerfile:1
FROM php:8.3-fpm-alpine

# Instala dependencias y extensiones
RUN apk add --no-cache --virtual .build-deps \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    autoconf \
    g++ \
    make \
    php-pear \
    bash \
    && apk add --no-cache \
    git \
    curl \
    bash \
    vim \
    nano \
    && docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl \
    zip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/src/php*

