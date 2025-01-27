FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN /usr/bin/apt-get update \
    && /usr/bin/apt-get install -y \
    tzdata \
    rsyslog \
    rsyslog-relp

ENV TZ=America/Chicago
ENV DEBIAN_FRONTEND=noninteractive

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && /usr/sbin/dpkg-reconfigure -f noninteractive tzdata

RUN groupadd rsyslog \
    && useradd rsyslog \
         --create-home \
         --home-dir /rsyslog \
         --shell /bin/bash

RUN mkdir -p /etc/rsyslog.d /rsyslog
COPY rsyslog.conf /etc/rsyslog.conf
COPY 10-server.conf /etc/rsyslog.d/10-server.conf

RUN /usr/bin/chown -R rsyslog:rsyslog /etc/rsyslog.conf /etc/rsyslog.d /rsyslog

USER rsyslog
ENTRYPOINT ["rsyslogd", "-n"]
