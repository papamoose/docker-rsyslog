#!/bin/bash -x

# Set the timezone symlink and update /etc/timezone
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

if [[ -v PUID && $PUID =~ ^[0-9]+$ ]] && [[ -v PGID && $PGID =~ ^[0-9]+$ ]]; then
  groupadd -g $PGID rsyslog
  useradd rsyslog \
      --uid $PUID \
      --gid $PGID \
      --home-dir /rsyslog \
      --shell /bin/bash
  options="-f /etc/rsyslog_noroot.conf"
  chown -R ${PUID}:${PGID} /rsyslog
else
  options="-f /etc/rsyslog.conf"
fi

# Execute the original entrypoint
exec /usr/sbin/rsyslogd -n ${options}
