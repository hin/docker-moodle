FROM alpine:3.4

RUN apk update

RUN apk add --no-cache \
    nginx \
    tini \
    git \
    bash \
    php5-cli \
    php5-fpm \
    php5-mysqli \
    php5-openssl \
    php5-iconv \
    php5-curl \
    php5-openssl \
    php5-xmlrpc \
    php5-soap \
    php5-ctype \
    php5-zip \
    php5-gd \
    php5-dom \
    php5-xml \
    php5-intl \
    php5-json \
    php5-zlib \
    php5-xmlreader \
    php5-opcache \
    mariadb \
    mariadb-client

ENTRYPOINT ["/sbin/tini", "--", "/start.sh"]

COPY rootfs /

RUN sed -i -e 's,^socket.*,socket = /var/run/mysqld.sock,' /etc/mysql/my.cnf
RUN sed -i -e 's,mysqli.default_socket.*,mysqli.default_socket = /var/run/mysqld.sock,' /etc/php5/php.ini

EXPOSE 4080

VOLUME /var/lib/mysql
VOLUME /var/moodledata
VOLUME /var/www

CMD usage
