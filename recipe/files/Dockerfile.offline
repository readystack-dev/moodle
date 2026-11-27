# GENERATED L-009 hermetic PHP build on Ubuntu's own packages (--network=none, SBOM+SLSA-attestation-producing).
# Pinned ubuntu:24.04; vendored app source + the deb closure (Ubuntu's PHP 8.3, its extensions, Apache, runtime debs).
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
# Apache + PHP set up as the official php:apache image sets them up (the image this product's Debian releases
# ran on), so the product's scaffold, post_copy_run and entrypoint behave as they did there.
COPY readystack-php.ini /etc/php/8.3/apache2/php.ini
COPY readystack-php.ini /etc/php/8.3/cli/php.ini
COPY readystack-mod-php.conf /etc/apache2/mods-available/php8.3.conf
COPY readystack-php.conf /etc/apache2/conf-available/readystack-php.conf
COPY apache2-foreground /usr/local/bin/apache2-foreground
RUN chmod 0755 /usr/local/bin/apache2-foreground && \
    sed -ri 's/^export ([^=]+)=(.*)$/: ${\1:=\2}\nexport \1/' /etc/apache2/envvars && \
    a2dismod -q mpm_event && a2enmod -q mpm_prefork && a2enconf -q readystack-php && \
    rm -rf /var/www/html && mkdir -p /var/www/html && chown www-data:www-data /var/www/html && chmod 1777 /var/www/html && \
    for d in /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/run/apache2/socks; do \
      rm -rf "$d" && mkdir -p "$d" && chown www-data:www-data "$d" && chmod 1777 "$d"; \
    done && \
    ln -sfT /dev/stderr /var/log/apache2/error.log && \
    ln -sfT /dev/stdout /var/log/apache2/access.log && \
    ln -sfT /dev/stdout /var/log/apache2/other_vhosts_access.log && \
    chown -R --no-dereference www-data:www-data /var/log/apache2
# Every module the product needs is loaded by the Apache AND the CLI configuration (the CLI binary reads
# each SAPI's php.ini + conf.d), or the build stops here instead of the product failing at start.
RUN for sapi in apache2 cli; do \
      PHP_INI_SCAN_DIR=/etc/php/8.3/$sapi/conf.d php -c /etc/php/8.3/$sapi/php.ini -r '$m = array_map("strtolower", array_merge(get_loaded_extensions(), get_loaded_extensions(true))); $x = array_diff(array_slice($argv, 1), $m); if ($x) { fwrite(STDERR, "missing PHP extensions: " . implode(", ", $x) . "\n"); exit(1); }' "iconv" "mbstring" "curl" "openssl" "ctype" "zip" "zlib" "gd" "simplexml" "spl" "pcre" "dom" "xml" "xmlreader" "intl" "json" "hash" "fileinfo" "sodium" "filter" "tokenizer" "soap" "exif" "mysqli" "zend opcache" || { echo "for the $sapi configuration"; exit 1; }; \
    done
ARG SOURCE_DATE_EPOCH=1795614453
RUN (getent passwd www-data >/dev/null 2>&1 || (groupadd -r www-data && useradd -r -g www-data -d /var/www/html www-data)) && \
    mkdir -p /var/www/moodledata /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY vendored/moodle-src/. /var/www/html
COPY moodle.ini /etc/php/8.3/mods-available/moodle.ini
COPY moodle-vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh
RUN phpenmod moodle && sed -ri 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf && a2enmod rewrite && chown www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/moodledata /var/run/apache2 /var/lock/apache2 /var/log/apache2
LABEL org.opencontainers.image.title="Moodle"
LABEL org.opencontainers.image.source="https://github.com/moodle/moodle"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.version="v5.3.1-CE-ubuntu24.04-r1"
LABEL org.opencontainers.image.description="Moodle — the world's open-source learning management system (GPL-3.0, PHP)."
LABEL org.opencontainers.image.vendor="Moodle Pty Ltd"
LABEL org.opencontainers.image.revision="cfe123f26fc7071981fe949cb16cd5a08a8234f1"
HEALTHCHECK --interval=5s --timeout=900s --start-period=600s \
  CMD curl -fsS --http1.0 -H 'Host:' http://127.0.0.1:8080/login/index.php | grep -q 'name="logintoken"' || exit 1
USER www-data
EXPOSE 8080
WORKDIR /var/www/html
STOPSIGNAL SIGWINCH
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
