FROM acweblabs/nginx-php8.1-fpm

COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1


# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/00-laravel-deploy.sh"]