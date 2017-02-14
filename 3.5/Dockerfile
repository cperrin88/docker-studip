FROM php:7-apache

ENV STUDIP_VERSION=3.5
ENV STUDIP_DOWNLOAD_URL="https://sourceforge.net/projects/studip/files/Stud.IP/3.5/studip-3.5.tar.bz2" \
    STUDIP_ARCHIVE_NAME="studip-$STUDIP_VERSION.tar.bz" \
    STUDIP_ARCHIVE_HASH_SHA1="c2bd770825112d8b0e18fd5bada1a2ed5eb43f1f" \
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
                          libldb-dev && \
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
    echo "$STUDIP_ARCHIVE_HASH_SHA1 $STUDIP_ARCHIVE_NAME" | sha1sum --check && \
    tar --extract --file "$STUDIP_ARCHIVE_NAME" && \
    rm "$STUDIP_ARCHIVE_NAME" && \
    mv "$STUDIP_DIR_NAME" /usr/local/studip && \
    ln -s /usr/local/studip/public /var/www/html/studip

RUN mv /usr/local/studip/config/config.inc.php.dist /usr/local/studip/config/config.inc.php && \
    mv /usr/local/studip/config/config_local.inc.php.dist /usr/local/studip/config/config_local.inc.php && \
    chmod a+rwx /tmp

ADD entrypoint /usr/local/bin

RUN chmod a+x /usr/local/bin/entrypoint

ADD php.ini /usr/local/etc/php

ENTRYPOINT ["entrypoint"]

EXPOSE 80
CMD ["apache2-foreground"]
