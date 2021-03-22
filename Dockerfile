FROM php:7-fpm-alpine
MAINTAINER Serg Bragin <bsm@kcentr.ru>

RUN apk add --update	\
    libmcrypt-dev		\
    postgresql-dev		\
    libpng-dev			\
    rabbitmq-c-dev		\
	libxml2-dev			\
    libzip-dev			\
    unzip				\
    wget				\
	git					\
    curl				\
	net-tools

RUN set -eux ; \
    docker-php-ext-install sockets zip pdo pdo_pgsql pgsql gd

RUN set -eux ; \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsq

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin && \
        echo "alias composer='composer'" >> /root/.bashrc && \
        composer


# Install phpunit
RUN wget https://phar.phpunit.de/phpunit-6.0.phar && \
        chmod +x phpunit-6.0.phar && \
        mv phpunit-6.0.phar /usr/local/bin/phpunit
        
COPY php.ini /usr/local/etc/php/php.ini
