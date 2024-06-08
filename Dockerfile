# Dockerfile
# Use base image for container
FROM richarvey/nginx-php-fpm:latest

WORKDIR /var/www/html

# Copy all application code into your Docker container
COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Update apk package manager and install necessary packages
RUN apk update && \
    apk add --no-cache npm php-bcmath

# Install NPM dependencies
RUN npm install

# Set Node.js options to increase memory limit
ENV NODE_OPTIONS=--max-old-space-size=4096

# Build Vite assets
RUN npm run build

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Ensure Composer uses the correct PHP version and install dependencies
RUN composer install --ignore-platform-reqs 


# Command to run the application
CMD ["/start.sh"]