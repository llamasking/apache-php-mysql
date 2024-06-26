FROM php:8-apache

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Add Extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gmp pdo_mysql mysqli

COPY docker-entrypoint.sh /docker/docker-entrypoint.sh
RUN chmod +x /docker/docker-entrypoint.sh
ENTRYPOINT ["/docker/docker-entrypoint.sh"]

CMD ["apache2-foreground"]
