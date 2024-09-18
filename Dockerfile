FROM wordpress:6-php8.2-apache

RUN apt-get update && apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

