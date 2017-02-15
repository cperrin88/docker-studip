FROM php:5-apache

LABEL maintainer "Christopher Perrin <cperrin@screebo.net>"

ENV STUDIP_VERSION=3.4.3
ENV STUDIP_DOWNLOAD_URL="https://sourceforge.net/projects/studip/files/Stud.IP/3.4/studip-3.4.3.tar.bz2" \
    STUDIP_ARCHIVE_NAME="studip-$STUDIP_VERSION.tar.bz" \
    STUDIP_ARCHIVE_HASH_SHA1="1dc8ec28d4ddb65b0b89755b3b15260e9b771bdc" \
    STUDIP_DIR_NAME="$STUDIP_VERSION"


RUN apt-get update && \
    apt-get install --yes wget \
                          lbzip2 \
                          zip \
                          unzip \
                          libssl-dev \
                          libcurl4-openssl-dev \
                          libxml2-dev \
                          libldap2-dev \
                          libldb-dev \
                          mysql-client && \
    apt-get clean && \
    rm --recursive /var/lib/apt/lists/*

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so && \
    docker-php-ext-install pdo_mysql \
                           mysqli \
                           gettext \
                           ftp \
                           curl \
                           bcmath \
                           xml \
                           ldap \
                           dom

RUN cd /tmp && \
    wget "$STUDIP_DOWNLOAD_URL" -O "$STUDIP_ARCHIVE_NAME" && \
    if [ -n "$STUDIP_ARCHIVE_HASH_SHA1" ]; then \
      echo "$STUDIP_ARCHIVE_HASH_SHA1 $STUDIP_ARCHIVE_NAME" | sha1sum --check; \
    fi && \
    tar --extract --file "$STUDIP_ARCHIVE_NAME" && \
    rm "$STUDIP_ARCHIVE_NAME" && \
    mv "$STUDIP_DIR_NAME" /usr/local/studip

RUN ln -s /usr/local/studip/public /var/www/html/studip && \
    mv /usr/local/studip/config/config_local.inc.php.dist /usr/local/studip/config/config_local.inc.php && \
    mv /usr/local/studip/config/config.inc.php.dist /usr/local/studip/config/config.inc.php && \
    chown --recursive www-data:www-data /usr/local/studip/public \
                                        /usr/local/studip/data && \
    chmod a+rwx /tmp

ADD entrypoint /usr/local/bin

RUN chmod a+x /usr/local/bin/entrypoint

ADD php.ini /usr/local/etc/php

ENTRYPOINT ["entrypoint"]

EXPOSE 80

CMD ["apache2-foreground"]
