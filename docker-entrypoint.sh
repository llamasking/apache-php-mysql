#!/usr/bin/env bash
#
# Performs setup tasks on container start

set -euo pipefail

# Set directory owner for docroot recursively
chown -R www-data:www-data /var/www/html/

exec "docker-php-entrypoint" $@
