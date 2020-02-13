FROM php:7.4.2-cli
MAINTAINER Serg Bragin <bsm@kcentr.ru>

RUN set -eux ; \
    apt-get update -yqq &&  \ 
    apt-get install -yqq    \
    libmcrypt-dev           \
    libpq-dev               \
    rsync                   \
    ssh                     \
    git                     \
    curl                    \
    libzip-dev              \
    npm                     \
    unzip

RUN set -eux ; \
    docker-php-ext-install sockets zip pdo pdo_pgsql pgsql

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
