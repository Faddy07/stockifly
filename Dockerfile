FROM acweblabs/nginx-php8.1-fpm


# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libpng-dev \
#     libjpeg62-turbo-dev \
#     libfreetype6-dev \
#     locales \
#     zip \
#     jpegoptim optipng pngquant gifsicle \
#     vim \
#     unzip \
#     git \
#     curl \
#     libonig-dev \
#     libzip-dev \
#     libbz2-dev \
#     libxml2-dev \
#     libxslt1-dev \
#     libssl-dev \
#     nodejs \
#     npm
    
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql mbstring zip exif pcntl bcmath gd

WORKDIR /app
COPY . /app
# RUN composer install

# CMD php artisan serve --host=0.0.0.0 --port=8000
CMD ["/start.sh"]
# EXPOSE 8000