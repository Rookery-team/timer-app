FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -my \
  curl \
  wget \
  php-curl \
  php-fpm \
  php-gd \
  php-xsl \
  php-mysqlnd \
#  php-mcrypt \
  php-cli \
  php-intl \
  php-bz2 \
  php-zip \
  php-mbstring \
  git \
  zip \
  php-apcu \
  php-redis \
  php-opcache

# RUN mkdir /run/php

ADD www.conf /etc/php/7.4/fpm/pool.d/www.conf
ADD php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
RUN ln -snf /usr/share/zoneinfo/Europe/Paris /etc/localtime

WORKDIR /var/www/html/backend

EXPOSE 9000

CMD ["php-fpm7.4"]
