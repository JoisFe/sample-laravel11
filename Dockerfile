FROM dunglas/frankenphp:latest-php8.3.7-alpine

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /app
RUN composer install
