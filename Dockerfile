FROM php:7.0-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
		wget \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli \
	&& usermod -u 1000 www-data && groupmod -g 1000 www-data
    
COPY config/custom.ini /usr/local/etc/php/conf.d/
COPY php-fpm/zcustom.conf /usr/local/etc/php-fpm.d/

