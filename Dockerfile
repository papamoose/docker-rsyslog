FROM ubuntu:latest

RUN userdel --force ubuntu

RUN /usr/bin/apt-get update \
  && /usr/bin/apt-get install -y \
    tzdata \
    rsyslog \
    rsyslog-relp

RUN mkdir -p /etc/rsyslog.d /rsyslog \
  && rm -f /etc/rsyslog.d/*.conf

COPY rsyslog.conf /etc/rsyslog.conf
COPY 10-server.conf /etc/rsyslog.d/10-server.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
