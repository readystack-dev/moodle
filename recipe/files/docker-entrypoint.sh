#!/bin/sh
set -e
cd /var/www/html
DATA=/var/www/moodledata
# A copy of config.php is kept on the moodledata VOLUME and copied back into the code tree on start, so a
# container re-create (every upgrade) finds the existing install instead of re-running the installer against
# a populated DB. It must be a COPY: config.php loads __DIR__/lib/setup.php, and PHP resolves __DIR__ through
# a symlink to the volume, which broke every page of the 5.2.3 build ("Failed opening required
# '/var/www/moodledata/lib/setup.php'") while /login/index.php still answered HTTP 200.
if [ -f "$DATA/config.php" ]; then
  [ -e config.php ] || cp "$DATA/config.php" config.php
else
  # A config.php in the code tree with no volume copy is a FAILED first boot's leftover: install.php writes
  # config.php BEFORE its environment check, so a refused check (a MariaDB whose default collation is not a
  # listed utf8mb4 one, or a server older than the required version) exits non-zero with config.php already
  # on disk. Drop it so a later `docker start`/`docker restart` never skips the installer and serves an
  # UNINSTALLED site (whose login page redirects to /admin/index.php, the web installer, which an
  # unauthenticated client could drive to completion and claim the site administrator account). The copy on
  # the volume, written only after the installer SUCCEEDS below, is the sole record that the site is installed.
  rm -f config.php
fi
# First boot: run the non-interactive CLI installer against the external MySQL/MariaDB (the
# orchestrator waits it healthy before this runs). No built-in passwords (audit 2026-09-25: the admin
# fell back to a fixed password, and the DB user's to 'moodle'): DB_PASS is required, and the admin
# password is MOODLE_ADMIN_PASS or — when unset — generated now and written only to
# $DATA/initial_admin_password (mode 600).
if [ ! -e config.php ]; then
  [ -n "${DB_PASS:-}" ] || { echo "First boot needs DB_PASS (the password of DB_USER on DB_HOST)." >&2; exit 1; }
  ADMIN_PW="${MOODLE_ADMIN_PASS:-}"
  if [ -z "$ADMIN_PW" ]; then
    # Moodle's default policy: 8+ chars with a digit, lower, upper and a symbol.
    ADMIN_PW="$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 20)Aa1!"
    ( umask 077; printf '%s\n' "$ADMIN_PW" > "$DATA/initial_admin_password" )
    echo "MOODLE_ADMIN_PASS not set — generated the admin password into $DATA/initial_admin_password"
  fi
  php admin/cli/install.php \
    --lang=en --non-interactive --agree-license \
    --wwwroot="${MOODLE_WWWROOT:-http://127.0.0.1:8080}" \
    --dataroot="$DATA" \
    --dbtype="${DB_TYPE:-mysqli}" \
    --dbhost="${DB_HOST:-db}" --dbport="${DB_PORT:-3306}" \
    --dbname="${DB_NAME:-moodle}" --dbuser="${DB_USER:-moodle}" --dbpass="$DB_PASS" \
    --prefix=mdl_ \
    --fullname="${MOODLE_FULLNAME:-ReadyStack Moodle}" --shortname="${MOODLE_SHORTNAME:-moodle}" \
    --adminuser="${MOODLE_ADMIN:-admin}" --adminpass="$ADMIN_PW" \
    --adminemail="${MOODLE_ADMIN_EMAIL:-admin@example.com}" \
    --chmod=2775
  unset ADMIN_PW
  ( umask 077; cp config.php "$DATA/config.php" )
fi
# An https:// wwwroot means TLS ends in front of this container, which serves plain HTTP on 8080. Without
# $CFG->sslproxy Moodle answers every request that arrives over HTTP with a redirect to the https address
# (lib/setuplib.php initialise_fullme), an endless loop behind the proxy. Add it (also to installs made by
# an earlier image) unless MOODLE_SSLPROXY=0 or config.php already sets sslproxy or reverseproxy.
if [ "${MOODLE_SSLPROXY:-1}" != 0 ] && grep -q "^\$CFG->wwwroot *= *'https://" config.php \
   && ! grep -q '^\$CFG->\(sslproxy\|reverseproxy\)' config.php; then
  sed -i "/^require_once(__DIR__ \. '\/lib\/setup\.php');/i \$CFG->sslproxy = true;" config.php
  grep -q '^\$CFG->sslproxy = true;' config.php
  ( umask 077; cp config.php "$DATA/config.php" )
  echo "https wwwroot: set \$CFG->sslproxy = true (TLS is terminated in front of this container)"
fi
exec apache2-foreground
