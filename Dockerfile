FROM php:7.1-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        mysql-client \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd \
        --with-jpeg-dir=/usr \
        --with-png-dir=/usr \
    && docker-php-ext-install gd opcache pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod rewrite headers && apachectl -t && service apache2 restart

ADD vhost.conf /etc/apache2/sites-available/000-default.conf

COPY php.ini /usr/local/etc/php/

WORKDIR /var/www/html/web
