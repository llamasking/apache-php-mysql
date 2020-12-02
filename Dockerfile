FROM php:7-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget

RUN savedAptMark="$(apt-mark showmanual)" && \
    apt-get install -y --no-install-recommends libgmp-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gmp && \
    docker-php-ext-install gmp mysqli pdo_mysql bcmath && \
    apt-mark auto '.*' > /dev/null && \
    apt-mark manual $savedAptMark && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get clean

COPY docker-entrypoint.sh /docker/docker-entrypoint.sh
COPY sourcebans.ini /usr/local/etc/php/conf.d/sourcebans.ini

RUN chmod +x /docker/docker-entrypoint.sh

ENTRYPOINT ["/docker/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
