#!/bin/bash
set -e

# Create SASL database if it doesn't exist
mkdir -p /etc/sasldb2

if [ -n "$SMTP_USER" ] && [ -n "$SMTP_PASSWORD" ]; then

    echo "$SMTP_PASSWORD" | saslpasswd2 \
        -p \
        -c \
        "$SMTP_USER"

fi

chown postfix:sasl /etc/sasldb2 2>/dev/null || true

service saslauthd start

postfix start-fg