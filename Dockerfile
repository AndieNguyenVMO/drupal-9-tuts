# Use an official PHP 8.1 image as a base
FROM php:8.1

# Install required PHP extensions
RUN apt-get update && \
    apt-get install -y \
        curl \
        libcurl4-openssl-dev \
        libzip-dev \
        libonig-dev \
        libsqlite3-dev \
        libxml2-dev \
        libssl-dev \
        libgd-dev \
        libmcrypt-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev && \
    docker-php-ext-install \
        bcmath \
        curl \
        gd \
        mbstring \
        mysqli \
        opcache \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        zip

# Install additional tools
RUN apt-get install -y \
        git \
        unzip \
        vim \
        wget \
        npm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Change the working directory to /var/www/html
WORKDIR /var/www/html


# Copy the Drupal code to the container
COPY . .

# Install dependencies using Composer
RUN composer install --no-interaction

# Expose port 8007
CMD ["php", "-S", "0.0.0.0:8007", "-t", "/var/www/html"]
