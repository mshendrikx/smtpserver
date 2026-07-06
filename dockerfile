FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postfix \
        postfix-pcre \
        sasl2-bin \
        libsasl2-modules \
        rsyslog \
        opendkim \
        opendkim-tools \
        openssl \
        ca-certificates \
        gettext-base \
        dnsutils \
        procps \
        supervisor && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p \
    /etc/postfix/templates \
    /etc/opendkim/keys \
    /etc/mail \
    /var/spool/postfix \
    /var/log/mail && \
    chown -R postfix:postfix /var/spool/postfix

# Copy configuration templates
COPY postfix/main.cf.template /etc/postfix/templates/main.cf.template
COPY postfix/master.cf.template /etc/postfix/templates/master.cf.template

# Copy startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Submission port
EXPOSE 587

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s \
CMD nc -z localhost 587 || exit 1

ENTRYPOINT ["/entrypoint.sh"]