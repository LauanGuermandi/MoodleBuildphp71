FROM php:7.1-fpm

# Update and install utils
RUN apt-get update && apt-get install -my wget gnupg
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && apt-get -y --no-install-recommends install apt-transport-https

# Installing dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    mysql-client \
    libpng-dev \
    locales \
    zip \
    git

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-install gd sockets bcmath
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv swoole

# Installing composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Allow container to write on host
RUN usermod -u 1000 www-data

# Create moodledata
RUN mkdir /var/www/moodledata && chmod 777 -R /var/www/moodledata
