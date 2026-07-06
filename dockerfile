FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y \
      postfix \
      sasl2-bin \
      libsasl2-modules \
      rsyslog && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]