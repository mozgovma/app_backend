FROM php:7.4.33-fpm-alpine

ENV XDEBUG_VERSION 3.1.2

RUN apk add --update --no-cache \
        $MUSL_LOCALE_DEPS \
        pcre-dev $PHPIZE_DEPS \
        fcgi \
        git \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libzip-dev \
        zip \
        libsodium-dev \
        icu-dev \
        icu-data-full \
    && git clone --branch $XDEBUG_VERSION --depth 1 https://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug \
    && docker-php-ext-configure \
        xdebug --enable-xdebug-dev \
    && docker-php-ext-configure \
        zip \
    && docker-php-ext-configure \
        gd --with-jpeg --with-freetype \
    && docker-php-ext-configure \
        intl \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} \
        gd \
        xdebug \
        zip \
        pdo \
        pdo_mysql \
        mysqli \
        intl \
        sodium \
        opcache \
    && pecl install redis \
    && docker-php-ext-enable redis.so intl \
    && apk del --no-cache \
        git

COPY ./php-fpm/conf.d /usr/local/etc/php/conf.d
COPY ./php-fpm/php-fpm.d /usr/local/etc/php-fpm.d

WORKDIR /app

COPY ./php-fpm/entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

HEALTHCHECK --interval=10s --timeout=3s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1
