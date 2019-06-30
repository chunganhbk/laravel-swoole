FROM php:7.3-alpine


ARG BUILD_DATE
ARG VCS_REF

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APP_DIR=/var/www/laravel-swoole
ENV SWOOLE_VERSION=4.3.5

#4.ADD-NGINX SUPERVISOR
RUN set -ex \
  	&& apk update
RUN apk add make nginx supervisor postgresql-dev libsodium  curl icu libpng freetype libjpeg-turbo postgresql-dev libffi-dev libsodium libzip-dev bash 
RUN apk add --virtual build-dependencies  icu-dev libxml2-dev freetype-dev libpng-dev libjpeg-turbo-dev g++ make autoconf libsodium-dev 


RUN docker-php-source extract \
    && pecl install swoole redis  \
    && docker-php-ext-enable swoole redis \
    && docker-php-source delete 
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) pgsql pdo_mysql pcntl sodium pdo_pgsql intl zip gd \
    && cd  / && rm -fr /src \
    && apk del build-dependencies \
    && rm -rf /tmp/* 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

RUN mkdir -p /run/nginx

ADD php.ini /etc/php7/php.ini	
ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD . $APP_DIR

WORKDIR $APP_DIR

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]

EXPOSE 8080
