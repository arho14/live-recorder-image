#!/bin/sh
set -eu

PUID="${PUID:-99}"
PGID="${PGID:-100}"
UMASK="${UMASK:-000}"

umask "$UMASK"

if [ "$(id -u)" = "0" ]; then
  mkdir -p /app/config /app/logs /app/backup_config /app/downloads
  chown -R "${PUID}:${PGID}" /app/config /app/logs /app/backup_config /app/downloads
  chmod -R u+rwX,g+rwX,o+rwX /app/config /app/logs /app/backup_config /app/downloads
  exec gosu "${PUID}:${PGID}" "$@"
fi

exec "$@"
