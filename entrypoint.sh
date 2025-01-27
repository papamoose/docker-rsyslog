#!/bin/bash

# Set the timezone symlink and update /etc/timezone
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Execute the original entrypoint
exec /usr/sbin/rsyslogd -n
