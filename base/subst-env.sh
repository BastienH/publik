#!/usr/bin/env bash

set -eu

/root/check-env.sh

export APPNAME=$1
envsubst '${ENV} ${DOMAIN} $AUTHENTIC_SUBDOMAIN $COMBO_SUBDOMAIN $COMBO_ADMIN_SUBDOMAIN $FARGO_SUBDOMAIN $HOBO_SUBDOMAIN $PASSERELLE_SUBDOMAIN $WCS_SUBDOMAIN $CHRONO_SUBDOMAIN $BIJOE_SUBDOMAIN' < "/etc/nginx/conf.d/$1.template" > "/etc/nginx/conf.d/$1.conf"
envsubst '$RABBITMQ_DEFAULT_USER $RABBITMQ_DEFAULT_PASS $RABBITMQ_PORT' < /etc/hobo-agent/settings.d/broker.template > /etc/hobo-agent/settings.d/broker.py
envsubst '$DB_HOBO_NAME $DB_PASSERELLE_NAME $DB_COMBO_NAME $DB_FARGO_NAME $DB_WCS_NAME $DB_AUTHENTIC_NAME $DB_CHRONO_NAME $DB_BIJOE_NAME $DB_HOBO_USER $DB_PASSERELLE_USER $DB_COMBO_USER $DB_FARGO_USER $DB_WCS_USER $DB_AUTHENTIC_USER $DB_CHRONO_USER $DB_BIJOE_USER $APPNAME $DEBUG $LOG_LEVEL $LOG_CHANNEL $ALLOWED_HOSTS $DB_PORT $DB_HOBO_PASS $DB_PASSERELLE_PASS $DB_COMBO_PASS $DB_FARGO_PASS $DB_WCS_PASS $DB_AUTHENTIC_PASS $DB_CHRONO_PASS $DB_BIJOE_PASS $RABBITMQ_DEFAULT_USER $RABBITMQ_DEFAULT_PASS $RABBITMQ_PORT $ERROR_MAIL_AUTHOR $ERROR_MAIL_ADDR $SMTP_HOST $SMTP_USER $SMTP_PASS $SMTP_PORT' < /root/pyenv.template > /home/pyenv.py
# Needs to be in a directory that can be read by a non-root user, so not "/root"
chmod 755 /home/pyenv.py
