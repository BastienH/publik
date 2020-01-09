#!/bin/bash

# Fail on errors
set -eu

# Wait for dependencies
/root/wait-for-it.sh -t 60 db:${DB_PORT}
/root/wait-for-it.sh -t 60 rabbitmq:${RABBITMQ_PORT}
/root/subst-env.sh

# Adapt configuration from ENV variables
envsubst '${ENV} ${DOMAIN}' < /etc/nginx/conf.d/wcs.template > /etc/nginx/conf.d/wcs.conf

# Start NGINX
service nginx start

# Start WCS
service wcs start

# Start HOBO Agent
service supervisor start

exec "$@"
