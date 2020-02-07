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
