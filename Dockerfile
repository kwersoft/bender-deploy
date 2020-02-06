FROM php:7.4.2-cli
MAINTAINER Serg Bragin <bsm@kcentr.ru>

RUN set -eux ; \
    apt-get update -yqq &&  \ 
    apt-get install -yqq libmcrypt-dev libpq-dev rsync ssh git curl;

RUN set -eux ; \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt install nodejs;

RUN set -eux ; \
    docker-php-ext-install sockets zip pdo pdo_pgsql pgsql;

RUN set -eux ; \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql;
