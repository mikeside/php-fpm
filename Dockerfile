# default install php7.4
ARG PHP_VERSION=7.4
FROM laradock/php-fpm:latest-${PHP_VERSION}

MAINTAINER Mike mikehub@aliyun.com
WORKDIR /var/www

# 更换源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY config/sources.list /etc/apt
RUN apt-get clean all && apt-get update -y

RUN apt-get install vim -y \
    && apt-get install wget -y \
    && apt-get install cmake -y \
    && apt-get install git -y \
    && apt-get install zip -y

# install compser
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer

# install php extend
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

RUN pecl install igbinary && docker-php-ext-enable igbinary
RUN apt-get install libzstd-dev -y
RUN pecl install redis && docker-php-ext-enable redis

RUN wget https://github.com/alanxz/rabbitmq-c/archive/refs/tags/v0.11.0.tar.gz
RUN tar -zxvf v0.11.0.tar.gz
RUN cd rabbitmq-c-0.11.0 && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/rabbitmq-c .. \
    && cmake --build . --target install
RUN apt-get install librabbitmq-dev -y
RUN echo "/usr/local/rabbitmq-c" | pecl install amqp \
    && docker-php-ext-enable amqp
RUN rm -rf v0.11.0.tar.gz  rabbitmq-c-0.11.0

RUN if [ $PHP_VERSION -ge 8.0 ]; then \
    echo y | pecl install swoole; \
    else \
    echo y | pecl install http://pecl.php.net/get/swoole-4.8.11.tgz; \
    fi
RUN docker-php-ext-enable swoole








